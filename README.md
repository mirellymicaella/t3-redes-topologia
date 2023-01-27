# T3 Redes - Roteamento

Para executar, basta chamar o script desejado. Por exemplo, para rodar a primeira topologia, bastar
executar:

```yml
./script_1.sh
```

Dessa forma, todos os roteadores serão "levantados" e também conexões/janelas do Telnet para cada
roteador serão abertas.

**Obs: pode ser necessário ajustar o tempo de sleep (sleep 5) entre os comandos para iniciar os roteadores e o
comando para abrir os terminais telnet devido ao tempo necessário para "subir" os roteadores ser diferente em
cada computador...*
Para finalizar tudo, basta chamar o script com a flag "-k":

```yml
./script_1.sh -k
```

Para realizar alguns testes, basta entrar no telnet correspondente e rodar os seguintes comandos:

```yml
ping <ip> /vrf v1
traceroute <ip> /vrf v1
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

Na topologia 1, temos uma rede com 5 elementos, implementada com roteamento estático.

Testes realizados na Topologia 1

## Mostrando a tabela de rotas para ipv4 e ipv6:

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
Testes realizados na Topologia 2

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


## Teste de ping e traceroute no roteador R1 para o roteador R2 usando ipv4:

R1->R3->R4
```C
ping 20.19.69.2   vrf v1
traceroute 20.19.69.2   vrf v1
```

![image](https://user-images.githubusercontent.com/45270882/215187581-bf83ee06-bfd1-4c6c-880f-3f94d61d8a4b.png)


## Teste de ping e traceroute no roteador R1 para o roteador R2 usando ipv6:
```C
ping 2019:66:4::2  vrf v1
traceroute 2019:66:4::2 vrf v1
```

![image](https://user-images.githubusercontent.com/45270882/215187618-a0c6ce12-7a7a-41db-915f-765c94390e83.png)


Desligando a interface eth2 do R3:

```yml
conf t
int eth2
shutdown
```

Podemos observar que em R3 houve um aviso no terminal, mostrando que os vizinhos (58.16.3.1 e
2016:58:3::1) "caíram" ("down"):

![71c6b55c-6829-41bf-bc67-fc0e0dfaa5cd](https://user-images.githubusercontent.com/45270882/214994574-e717b2a6-83e8-425f-a1ad-c97a72c4a13a.png)

![image](https://user-images.githubusercontent.com/45270882/215187649-6f142f59-6fed-4087-a970-3075a842458d.png)

![image](https://user-images.githubusercontent.com/45270882/215187700-2b4c5838-93d5-409b-b8c9-c4d552dee60d.png)
