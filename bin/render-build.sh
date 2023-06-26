set -o errexit

Bundle install
Bundle exec assets:precompile
Bundle exec assets:clean
Bundle exec db:migrate