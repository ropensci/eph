# eph 1.0.1
* fixed organize_labels bug

# eph 1.0.0
* added new functions: get_total_urbano() and get_eahu() (as well as their auxiliar internal functions)
* improved documentation and site 
* added contributing and codemeta.json files
* improved error messages using cli package
* reduced dependencies relying on base r and improved deprecated code 
* re-structured functions using the early return philosophy
* styled code according to the tidyverse style guide
* modified get_microdata function to avoid parameter conflicts between trimester and wave
* fixed map_agglomerates bug
* added additional tests 


# eph 0.6.1
* fixed bug in get_microdata() originated in a change in INDEC's URL (old datasets are now directly downloaded from a stable github repo)

# eph 0.6.0
* removed 'readr' and 'tidyverse' from Imports. readr was reclassified as a Suggest (because it was only used in a vignette) and tidyverse was replaced by the tidyverse packages actually required.
* improved error messages in `calculate_tabulates()` function.

# eph 0.5.1
* fixed warnings when downloading poverty lines 

# eph 0.5.0
* improve `get_microdata()` internals
* remove `questionr` dependency
* add group_vars and window argument to calculate_poverty
* add function `calculate_errors()` 
* add affix_sign argument to `calculate_tabulates()`

# eph 0.4.0

* add option destfile to `get_microdata()`
* add vignettes on poverty calculations
* add option to `get_poverty_lines()` to download regional baskets

# eph 0.3.1

* rename organize_ocupations --> `organize_cno()` for consistency
* add function `organize_caes()`
* fixed compatibility with dplyr 1.0

# eph 0.3.0

* improve `get_microdata_internal()` internals
* fixed compatibility with tibble 3.0.0
* add dataset on centroids of aglomerates of the survey
* add function `map_agglomerates()` for mapping indicators

# eph 0.2.0
* enhace `get_microdata()`. Now downloads multiple datasets and allows to pre-select variables
* add skip_if_offline and some skip_on_cran for time-consuming tests
* add stop if there is no internet connection for `get_microdata()`
* add vignettes
* simplify output in `organize_panels()`
* add function organize_ocupations


# eph 0.1.1

* Added a `NEWS.md` file to track changes to the package.
* Bug fix in `get_microdata()`
* Added Authors@ information (orcid)
* add bugreport to DESCRIPTION


