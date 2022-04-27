# declarar variáveis USERNAME TOKEN OWNER REPO em .env
# USERNAME=username do github
# TOKEN=um token de acesso pessoal
# OWNER=administrador do projeto, pode ser o mesmo username
# REPO=nome do repositório

username=`grep USERNAME .env | cut -d"=" -f2`
token=`grep TOKEN .env | cut -d"=" -f2`
owner=`grep OWNER .env | cut -d"=" -f2`
repo=`grep REPO .env | cut -d"=" -f2`

echo "Deseja gerar uma nova tag? (s/n)"

read choice

if [ "$choice" = "s" ]
then
    echo "Informe o título da tag: "
    read title
    echo "Informe a mensagem da tag: "
    read message
    echo "Informe a chave SHA: "
    read object

    curl \
    -u $username:$token \
    -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/$owner/$repo/git/tags \
    -d '{"tag":"'$title'","message":"'$message'", "object":"'$object'", "type":"commit"}'
fi

if [ "$choice" = "n" ]
then
    curl \
    -u $username:$token \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/$owner/$repo/tags
fi
