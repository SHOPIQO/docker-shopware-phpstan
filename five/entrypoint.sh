#!/bin/bash -e

cd /src

if [ ! -d .git ]; then
    echo "No .git directory found. Exiting."
    exit 1
fi

if [ -z "$(git diff --name-only --staged -- .)" ]; then
    echo "No staged files found. Exiting."
    exit 0
fi

if [ -z "$(git diff --name-only --staged -- . | grep -E '\.php$')" ]; then
    echo "No staged PHP files found. Exiting."
    exit 0
fi

for file in $(git diff --name-only --staged -- .); do
    if [[ $file == *.php ]]; then
        if [[ -e $file ]]; then
            rsync -R $file /home/application/.staged_files
        fi
    fi
done

if [ -e ./phpstan.neon ]; then
    config="./phpstan.neon"
else
    config="/home/application/shopware/phpstan.neon"
fi

if [ -z "$@" ]; then
    /usr/local/bin/php \
        /home/application/shopware/dev-ops/analyze/vendor/bin/phpstan \
        analyze \
        -c $config -- /home/application/.staged_files
else
    /usr/local/bin/php \
        /home/application/shopware/dev-ops/analyze/vendor/bin/phpstan \
        "$@"
fi
