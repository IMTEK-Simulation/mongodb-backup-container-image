# IMTEK Simulation MongoDB backup service

[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/imteksim/mongodb-backup?label=dockerhub&sort=semver)](https://hub.docker.com/repository/docker/imteksim/mongodb-backup) [![GitHub Workflow Status](https://img.shields.io/github/workflow/status/IMTEK-Simulation/mongodb-backup-container-image/publish)](https://github.com/IMTEK-Simulation/mongodb-backup-container-image/actions?query=workflow%3Apublish)

Copyright 2020, 2021 IMTEK Simulation, University of Freiburg

Author: Johannes Hoermann, johannes.hoermann@imtek.uni-freiburg.de

## Introduction

Does not run any `mongod` instance, but provides backup and administration utilities.

## TODO

* Run full and incremental backups as cronjobs.

## Configuration

Expects a backup volume provided at `/data/backup`. Per default,
backups are stored within three subdirectories on this volume,

* `DB_OPLOG_DUMP` for (automized) incremental oplog backups.
* `DB_FULL_DUMP` for (automized) full backups.
* `DB_FILTERED_DUMP` for (manual) selective backups.


## Envionment variables

* `SMB_HOST` - name of host providing smb share, default: `sambaserver`
* `SMB_SHARE` - name of share, default: `sambashare`
* `SMB_MOUNT_OPTIONS` - CIFS mount options for smb share, default: `rw,iocharset=utf8,credentials=/run/secrets/smb-credentials,file_mode=0600,dir_mode=0700`

## Secrets

* `/run/secrets/username` - mongodb username
* `/run/secrets/password` - mongodb password
* `/run/secrets/tls_cert.pem` - tls cerificate for this backup service
* `/run/secrets/tls_key.pem` - tls key for this backup service
* `/run/secrets/tls_key_cert.pem` - key and certificate for backup service
* `/run/secrets/rootCA.pem` - root CA
* `/run/secrets/public_host` - public name of mongod host (used for init_rs.sh)
* `/run/secrets/smb-credentials`- credentials file for smb share, see i.e. mount.cifs(8), https://www.samba.org/~ab/output/htmldocs/manpages-3/mount.cifs.8.html

## Content

* `list_dbs.py` lists all databases within `mongod`.
* `init_rs.sh` initializes a replica set if not done previously. This is required for ...
* `incremental_backup.sh` to create incremental oplog backups.
* `full_backup.sh` dumps everything under `mongod`.
* `filtered_backup.sh` dumps databases whose name match a regular expression.
* `incremental_restore.sh` (untested) replays incremental oplog backups created by `incremental_backup.sh`, but requires ...
* `full_restore.sh` (untested) to have restored the latest full backup by `full_dump.sh` beforehand.
* `filtered_restore.sh` restoresdatabases matching a specific regular expression from a (partial or full) backup.

# References

* https://dba.stackexchange.com/questions/107987/mongodb-incremental-backups
* https://tech.willhaben.at/mongodb-incremental-backups-dff4c8f54d58
* https://gist.github.com/taxilian/3d74f381954ca883d64f86e43786bb09

all accessed on 2020/05/26
