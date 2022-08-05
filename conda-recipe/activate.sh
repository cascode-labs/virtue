#!/bin/bash
# Default cdsprj, can be overwritten by users
if ! command -v cdsprj &> /dev/null
then
    cdsprj ()
    {
         cd -- "$1" || exit
    }
fi

# Default viewprj, can be overwritten by users
# Should be setup by users to open a project read-only
if ! command -v viewprj &> /dev/null
then
    viewprj ()
    {
         cd -- "$1" || exit
    }
fi
