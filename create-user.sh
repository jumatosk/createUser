#!/bin/bash

INIC() {
[ $UID != 0 ] && { echo -e "\n Logue com o usuario \"root\"\n" ; exit ; } || echo ""
read -p " Informe o nome do usuario: " LOGIN
[ $(egrep -wo "^$LOGIN" /etc/passwd) ] && ERROLOGIN || ADDUSER
}

ADDUSER() {
read -p " Informe o nome: " NOME
groupadd "$LOGIN"
PASS00=$(makepasswd --crypt-md5 --chars 6) #GERA SENHA CRIPTOGRAFADA (06 CARACTERES)
PASS01=$(awk '{print $1}' <<< "$PASS00") #SENHA
PASS02=$(awk '{print $2}' <<< "$PASS00") #SENHA CRIPTO
useradd -c "$NOME" -p "$PASS02" -d /home/$LOGIN -m -g $LOGIN -s /bin/bash $LOGIN
[ $(egrep -wo "^$LOGIN" /etc/passwd) ] && MSGOK || ERROCAD
}

ERROLOGIN() { echo -e "\nO usuario: $LOGIN\n já existe no sistema\n" ; exit ; }

MSGOK() { echo -e "\nCadastro realizado com sucesso.\n\nUsuario: $LOGIN\n Nome: $NOME\n Senha: $PASS01\n" ; }

ERROCAD() { echo -e "\n Problemas no cadastro do usuario: $LOGIN" ; }
