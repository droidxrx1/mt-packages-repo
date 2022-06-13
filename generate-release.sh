#!/bin/sh
set -e

do_hash() {
    HASH_NAME=$1
    HASH_CMD=$2
    echo "${HASH_NAME}:"
    for f in $(find -type f); do
        f=$(echo $f | cut -c3-) # remove ./ prefix
        if [ "$f" = "Release" ]; then
            continue
        fi
        echo " $(${HASH_CMD} ${f} | cut -d" " -f1) $(wc -c $f)"
    done
}

cat <<EOF
Origin: MT-Manager Packages
Label: Apt repo MT-Manager
Suite: stable
Codename: stable
Version: 2.0
Architectures: aarch64
Components: main
Description: Packages repository for MT-Manager
Date: $(date -Ru)
EOF
do_hash "MD5Sum" "md5sum"
do_hash "SHA1" "sha1sum"
do_hash "SHA256" "sha256sum"
