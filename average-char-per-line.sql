-- Original query can be found here:
-- https://console.cloud.google.com/bigquery?sq=226172199733:882da7fa2e7f4c1ab147e7831aa2b8e9

-- CAVEATS:
-- * This query is quite expensive to run on the full public dataset, ~$30. If
--   you are just interested in trying it out, I recommend commenting out the
--   first subquery and replacing with the version below, which uses a much
--   smaller sample table.
-- * This computes the _average_ amount of indentation per line. A better
--   measure would have been the the _mode_, but that would be much more
--   difficult to compute.
-- * This includes indentation on code comments, which should be fine as comments
--   usually inherit the indentation of the code context

WITH cleaned_contents as (
  SELECT
    REGEXP_REPLACE(
      REGEXP_REPLACE(c.content, r'\t', ' '), -- replace tabs with spaces
      r'(\n|\r|\v){2,}', -- remove blank lines
      '\n'
    ) cleaned_content,
    REGEXP_SUBSTR(f.path, r'\.\w+$') as language
  FROM bigquery-public-data.github_repos.contents c
  JOIN bigquery-public-data.github_repos.files f ON c.id = f.id
  WHERE 0=0
    and not c.binary
    -- non-text files (e.g. images) have no content but have sizes > 0
    and c.content is not null
    -- exclude files that are really large, as they likely weren't hand written
    and c.size < 15000
    -- the file needs to have a non-trivial amount of content
    and c.size > 100
    and REGEXP_SUBSTR(f.path, r'\.\w+$') in (
       -- file extensions for the most popular languages
          '.js', '.ts', '.rb', '.py', '.cs', '.cc', '.php', '.cpp', '.cxx',
          '.java', '.c', '.sh', '.r', '.sql', '.swift', '.h', '.m', '.html',
          '.css', '.scss', '.less', '.sass', '.rs', '.rlib', '.go', '.sc',
          '.scala', '.ps1'
    )
    -- Comment out the query above and replace with this query if you want to
    -- test against a *much* smaller data set
    --
    -- SELECT
    --   REGEXP_REPLACE(
    --     REGEXP_REPLACE(content, r'\t', ' '), -- replace tabs with spaces
    --     r'(\n|\r|\v){2,}', -- remove blank lines
    --     '\n'
    --   ) cleaned_content,
    --   REGEXP_SUBSTR(sample_path, r'\.\w+$') as language
    -- FROM bigquery-public-data.github_repos.sample_contents
    -- WHERE 0=0
    --   and not binary
    --   -- non-text files (e.g. images) have no content but have sizes > 0
    --   and content is not null
    --   -- exclude files that are really large, as they likely weren't hand written
    --   and size < 15000
    --   -- the file needs to have a non-trivial amount of content
    --   and size > 100
    --   and REGEXP_SUBSTR(sample_path, r'\.\w+$') in (
    --     -- file extensions for the most popular languages
    --     '.js', '.ts', '.rb', '.py', '.cs', '.cc', '.php', '.cpp', '.cxx',
    --     '.java', '.c', '.sh', '.r', '.sql', '.swift', '.h', '.m', '.html',
    --     '.css', '.scss', '.less', '.sass', '.rs', '.rlib', '.go', '.sc',
    --     '.scala', '.ps1'
    --   )
), cleaned_content_plus_metadata as (
  SELECT
    *,
    (CASE language
      WHEN '.py' then 'python'
      WHEN '.ts' then 'javascript'
      WHEN '.js' then 'javascript'
      WHEN '.rb' then 'ruby'
      WHEN '.sh' then 'shell'
      WHEN '.r' then 'r'
      WHEN '.sql' then 'sql'
      WHEN '.swift' then 'swift'
      WHEN '.php' then 'php'
      WHEN '.java' then 'java'
      WHEN '.cs' then 'c#'
      WHEN '.cpp' then 'c++'
      WHEN '.cc' then 'c++'
      WHEN '.cxx' then 'c++'
      WHEN '.c' then 'c'
      WHEN '.h' then 'objective c'
      WHEN '.m' then 'objective c'
      WHEN '.html' then 'html'
      WHEN '.css' then 'css'
      WHEN '.scss' then 'css'
      WHEN '.sass' then 'css'
      WHEN '.less' then 'css'
      WHEN '.rs' then 'rust'
      WHEN '.rlib' then 'rust'
      WHEN '.go' then 'go'
      WHEN '.scala' then 'scala'
      WHEN '.sc' then 'scala'
      WHEN '.ps1' then 'powershell'
      ELSE language
      END) as language_name,
    -- Replace one or more spaces following a line break with the line break alone.
    REGEXP_REPLACE(cleaned_content, r'(\n|\r|\v)\s+', '\\1') as cleaned_content_without_indentation,
    ARRAY_LENGTH(SPLIT(cleaned_content, '\n')) as line_count
  FROM cleaned_contents
  WHERE 0=0
    -- There needs to be at least one line with leading whitespace, otherwise
    -- we assume it was auto-generated.
    and REGEXP_CONTAINS(cleaned_content, r'\n\s+')
), final_content_data as (
  SELECT
    *,
    CHAR_LENGTH(cleaned_content) - CHAR_LENGTH(cleaned_content_without_indentation) as total_chars_indented
  FROM cleaned_content_plus_metadata
)

SELECT
  language_name,
  COUNT(*) as files_analyzed,
  SUM(total_chars_indented) as total_indentation,
  SUM(line_count) as total_lines,
  ROUND(SUM(total_chars_indented) / SUM(line_count), 2) as average_spaces_indented
FROM final_content_data
GROUP BY language_name
ORDER BY average_spaces_indented DESC
