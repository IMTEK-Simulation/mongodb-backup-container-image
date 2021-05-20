# mofified from source: https://gist.github.com/taxilian/3d74f381954ca883d64f86e43786bb09#file-initparams-inc-sh
# accessed 2020/05/26

function initStaticParams
{
    # at least according to their --help text, mongodump and mongorestore
    # still want the deprecated ssl opts...
    SSL_OPTS="--ssl --sslCAFile /run/secrets/rootCA.pem \
            --sslPEMKeyFile /run/secrets/tls_key_cert.pem \
            --sslAllowInvalidHostnames"

    # ... while mongoshell itself wants new tsl opts:
    TLS_OPTS="--tls --tlsCAFile /run/secrets/rootCA.pem \
        --tlsCertificateKeyFile /run/secrets/tls_key_cert.pem \
        --tlsAllowInvalidHostnames"

    AUTH_OPTS="--host mongodb --port 27017 \
        --authenticationDatabase=$(cat /run/secrets/username) \
        --username=$(cat /run/secrets/username) \
        --password=$(cat /run/secrets/password)"

    PUBLIC_HOST="$(cat /run/secrets/public_host)"

    LOG_MESSAGE_ERROR=1
    LOG_MESSAGE_WARN=2
    LOG_MESSAGE_INFO=3
    LOG_MESSAGE_DEBUG=4
    LOG_LEVEL=${LOG_MESSAGE_DEBUG}
}

function log
{
   MESSAGE_LEVEL=$1
   shift
   MESSAGE="$@"

   if [ ${MESSAGE_LEVEL} -le ${LOG_LEVEL} ]; then
      echo "$(date +'%Y-%m-%dT%H:%M:%S.%3N') ${MESSAGE}"
   fi
}

initStaticParams
