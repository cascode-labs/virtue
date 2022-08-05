#!/bin/tcsh
# Default cdsprj, can be overwritten by users
if ( ! `where cdsprj` == "" ) then
    alias cdsprj cd !:1
endif

# Default cdsprj, can be overwritten by users
# Should be setup by users to open a project read-only
if ( `where viewprj` != "" ) then
    alias viewprj cd !:1
endif
