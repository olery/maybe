# This configuration file is used to test/build the project on Olery's private
# Jenkins instance. Patches containing changes to this file made by people
# outside of Olery will most likely be rejected.

# The name of the project, used for other settings such as the PostgreSQL
# database and the package name.
PROJECT_NAME="maybe"

# The command to run for the test suite.
TEST_COMMAND="rake jenkins --trace"
