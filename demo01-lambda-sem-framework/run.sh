# 1o passo criar arquivo de politicas de segurança
# 2o criar role de segurança na AWS

aws iam create-role \
    --role-name lambda-exemplo \
    --assume-role-policy-document file://politicas.json \
    | tee logs/role.log

# 3o criar arquivo com conteúdo e zipá-lo
zip function.zip index.js

# 4o criação da função lambda
aws lambda create-function \
    --function-name hello-cli \
    --zip-file fileb://function.zip \
    --handler index.handler \
    --runtime nodejs12.x \
    --role <arn-from-lambda-create.log> \
    | tee logs/lambda-create.log

#5o invoke lambda!
aws lambda invoke \
    --function-name hello-cli \
    --log-type Tail \
    logs/lambda-exec.log

#6o atualizar, zipar
zip function.zip index.js

#7o atualizar lambda
aws lambda update-function-code \
    --zip-file fileb://function.zip \
    --function-name hello-cli \
    --publish \
    | tee logs/lambda-update.log

#8o invokar lambda atualizada
aws lambda invoke \
    --function-name hello-cli \
    --log-type Tail \
    logs/lambda-exec-update.log

#9o remover lambda
aws lambda delete-function \
    --function-name hello-cli

#10o remover IAM
aws iam delete-role \
    --role-name lambda-exemplo