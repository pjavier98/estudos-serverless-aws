# instalar
npm i -g serverless

# sls -v
# serverless -v

# sls inicializar
sls

# sempre fazer deploy antes de tudo para 
# verificar que o ambiente esta ok
sls deploy --aws-profile <profile-name>

# invocar na AWS
sls invoke -f hello --aws-profile <profile-name> --log

# invar local
sls invoke local -f hello --aws-profile <profile-name> --log

# configurar dashboard
sls

# logs
sls logs -f hello -t
sls logs -f hello --tail

# remover
sls remove --aws-profile <profile-name>

