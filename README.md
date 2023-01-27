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

Para realizar alguns testes, basta entrar no telnet correspondente e rodar os seguintes comandos: (neste
caso um exemplo para o ip pode ser 58.16.1.1 por exemplo)

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



`show ipv6 route v1`



## Teste de ping e traceroute no roteador R1 para o roteador R2 usando ipv4:

```C
ping 20.19.66.1 vrf v1
traceroute 20.19.66.1 /vrf v1
```




Teste de ping e traceroute no roteador R1 para o roteador R2 usando ipv6:

```C
ping 2019:66:1::1 /vrf v1
traceroute 2019:66:1::1 /vrf v1
```









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

![image](https://user-images.githubusercontent.com/45270882/214989601-30e63bfb-ad37-4697-97d9-56644f09405e.png)

## Teste de ping e traceroute no roteador R1 para o roteador R2 usando ipv6:
```C
ping 2019:66:4::2  vrf v1
traceroute 2019:66:4::2 vrf v1
```

![image](https://user-images.githubusercontent.com/45270882/214993368-2538fec9-097a-42e9-8871-1a839ca8390e.png)

Desligando a interface eth2 do R3:

```yml
conf t
int eth2
shutdown
```

Podemos observar que em R3 houve um aviso no terminal, mostrando que os vizinhos (58.16.3.1 e
2016:58:3::1) "caíram" ("down"):

![71c6b55c-6829-41bf-bc67-fc0e0dfaa5cd](https://user-images.githubusercontent.com/45270882/214994574-e717b2a6-83e8-425f-a1ad-c97a72c4a13a.png)

