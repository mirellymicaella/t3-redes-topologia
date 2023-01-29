# T3 Redes - Roteamento

É necessário informar que a matricula utilizada para gerar as máscaras do ipv4 e ipv6, foi a matricula da aluna Joana Venturin Loureiro: 2019109666.

Para executar, basta chamar o script desejado. Por exemplo, para rodar a primeira topologia, bastar
executar:

```yml
./script-rip.sh
```

Dessa forma, todos os roteadores serão "levantados" e também conexões/janelas do Telnet para cada
roteador serão abertas.

**Obs: pode ser necessário ajustar o tempo de sleep (sleep 5) entre os comandos para iniciar os roteadores e o
comando para abrir os terminais telnet devido ao tempo necessário para "subir" os roteadores ser diferente em
cada computador...*


Para realizar alguns testes, basta entrar no telnet correspondente e rodar os seguintes comandos:

```yml
ping <ip> vrf v1
traceroute <ip> vrf v1
```

Para desativar alguma interface, entrar no menu de configuração, depois no menu da interface desejada e
por fim o comando shutdown. Por exemplo:

```yml
conf t
int eth1
shutdown
```

# Topologia 1 
Rede da topologia 1

![image](https://user-images.githubusercontent.com/45270882/215202589-79a8e1dd-8ad5-4bca-97ff-9b33bc3da4fe.png)



Na topologia 1, temos uma rede com 5 elementos, implementada com roteamento estático.

##  Mostrando a tabela de rotas para ipv4 e ipv6: </h4>

`show ipv4 route v1`


![image](https://user-images.githubusercontent.com/45270882/215189632-3bcddc12-da5c-4032-928d-44b112ce29cf.png)


`show ipv6 route v1`


![image](https://user-images.githubusercontent.com/45270882/215189664-3b7cb1cc-1463-47c2-8764-ece889c7ef84.png)


## Teste de ping e traceroute no roteador R1 para o roteador R5 usando ipv4:

```C
ping 20.19.69.2 vrf v1
traceroute 20.19.69.2 vrf v1
```

![image](https://user-images.githubusercontent.com/45270882/215183590-c5eaba5a-c43e-4024-b192-96a5689f92d5.png)


## Teste de ping e traceroute no roteador R1 para o roteador R5 usando ipv6:

```C
ping 2019:66:4::2 vrf v1
traceroute 2019:66:4::2 vrf v1
```


![image](https://user-images.githubusercontent.com/45270882/215183616-92289ed6-e960-4291-88c7-2d4e91797f7c.png)


Podemos reparar que o caminho realizado entre os roteadores para a comunicação é: R1 para R2 para R4 e finalmente chegando ao R5.

Desligando a interface eth1 do R2, para que, como demonstrado no desenho, o R1 não tenha conexão alguma com o R5:

```yml
conf t
int eth1
shutdown
```

Novamente ralizamos os testes de ping e traceroute no roteador R1 para o roteador R5 usando ipv4 e ipv6:

![image](https://user-images.githubusercontent.com/45270882/215184168-5e992f60-75b9-4406-a773-93ca986c7b8d.png)

![image](https://user-images.githubusercontent.com/45270882/215184205-84a2926b-a572-48a5-9008-315e14f2479b.png)

Concluimos que os pacotes não chegam até R2, porém se a interface eth1 for ligada novamente, a rede volta a funcionar sem problemas.


# Rede da topologia 2
Na topologia 2, temos uma rede Full-mesh implementada com o algoritmo de roteamento RIP (mais
precisamente RIP2).

![image](https://user-images.githubusercontent.com/45270882/215201943-013fc8d6-1e0b-4402-ae56-ba3c08d4ead3.png)

## Mostrando a tabela de rotas para ipv4 e ipv6:

`show ipv4 route v1`

![image](https://user-images.githubusercontent.com/45270882/214986130-b729b2ce-024a-49ac-9de6-546d9dceb1b5.png)


`show ipv6 route v1`

![image](https://user-images.githubusercontent.com/45270882/214986248-9e019f9e-d6c5-4da9-8a7a-1321fc46f4eb.png)


Depois de 30 segundos, a tabela de rotas foi atualizada tanto para ipv4 e ipv6 (RIP em funcionamento):

`show ipv4 route v1`

![image](https://user-images.githubusercontent.com/45270882/214986455-e9eee6a6-7c61-4c0c-8fb8-19059aad503d.png)

`show ipv6 route v1`

![image](https://user-images.githubusercontent.com/45270882/214986575-57d6987a-89e3-40b4-8904-cff9e66aee05.png)

Podemos ver no terminal do roteador o aviso de que chega um "datagram" que os vizinhos estão "up"
(exemplo do R1):

`tmux a -t rare`

![image](https://user-images.githubusercontent.com/45270882/214987186-b7b8e95a-bc99-455d-ae10-29258fa705b8.png)


## Teste de ping e traceroute no roteador R1 para o roteador R4 usando ipv4:

```C
ping 20.19.69.2   vrf v1
traceroute 20.19.69.2   vrf v1
```

![image](https://user-images.githubusercontent.com/45270882/215200068-81ddda4d-4368-412e-9882-b67bb45e25ff.png)



## Teste de ping e traceroute no roteador R1 para o roteador R4 usando ipv6:
```C
ping 2019:66:4::2  vrf v1
traceroute 2019:66:4::2 vrf v1
```
![image](https://user-images.githubusercontent.com/45270882/215200897-a7267c93-b2be-4a5d-9ef7-57e1214804b3.png)



Como podemos visualizar nas imagens acima, utilizando o ipv4 o caminho seguido pacote é R1 para R3 que chega a R4. Já no ipv6, é realizada a passagem do pacote diretamente entre o R1 para o R4, sem passar pelo R3 (pode-se questionar se foi escolhido o caminho mais rápido na rede).

Desligando a interface eth2 do R3:

```yml
conf t
int eth2
shutdown
```

Podemos observar que em R3 houve um aviso no terminal, mostrando que os vizinhos (58.16.3.1 e
2016:58:3::1) "caíram" ("down"):

![71c6b55c-6829-41bf-bc67-fc0e0dfaa5cd](https://user-images.githubusercontent.com/45270882/214994574-e717b2a6-83e8-425f-a1ad-c97a72c4a13a.png)

Refazendo os pings ipv4 e ipv6:

![image](https://user-images.githubusercontent.com/45270882/215198446-53ebd42b-f1fd-488c-a002-1790ad56307c.png)
![image](https://user-images.githubusercontent.com/45270882/215198562-e8588f08-79aa-45d9-9a96-c14fb1cbd9c4.png)

Ao fazer o traceroute ipv4, é possível visualizar que os pacotes não chegam mais ao R4. Já no traceroute ipv6, como ele não realiza o caminho passando pelo R3, os pacotes são transmitidos normalmente.


Após aproximadamente 2 minutos, utilizando ipv4, uma nova rota é criada para ser possível realizar a passagem do pacote entre o R1 e R4, como é possível observar na imagem a seguir. Lembrando que não é criada uma nova rota para o ipv6 já que o mesmo não utilizou o eth2 do R3 para realizar o caminho do R1 para o R4.

![image](https://user-images.githubusercontent.com/58488905/215357967-5e4246f5-28e7-4670-a0d1-d0341e68b3a3.png)

Observando as tabelas após:
![image](https://user-images.githubusercontent.com/58488905/215358016-9787b7e8-9c8d-4780-92b2-68912d96ac01.png)

![image](https://user-images.githubusercontent.com/45270882/215187700-2b4c5838-93d5-409b-b8c9-c4d552dee60d.png)

