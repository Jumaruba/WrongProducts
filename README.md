<h3 align="center"> 
  WrongProducts
</h3> 
<p align="center">Program in PROLOG SICstus to solve the Wrong Products problem </p>

<br>

<br> 

## O problema
<div align="center">
<img src="https://i.imgur.com/hOCMtvV.png" > 
</div>
 
_Source_: [Logic Masters India](https://logicmastersindia.com/lmitests/dl.asp?attachmentid=790&view=1)  
<br> 

## Dependências 
Tenha o SICStus prolog instalado em seu computador.  
## Instruções de uso 

Para carregar o programa faça consult do ficheiro `main.pl` com o SICStus prolog.  

Existem 3 predicados principais para executar o programa: 

```prolog 
solve(+ColumnProducts, +RowProducts, +Distinct, -Board).  
solveWithStatistics(+ColumnProducts, +RowProducts, +Distinct, -Board). 
generate_and_solve(+Side, +Distinct, -Board).  
```

- O predicado `solve/4` apenas resolve o problema sem disponibilizar informações acerca das estatísticas de execução.    
- `solveWithStatistics/4` resolve o problema e disponibiliza estatísticas do programa.  
- `generate_and_solve/3` gera dinamicamente o problema e a seguir o soluciona utilizando o predicado `solveWithStatistics/4`. 

## Geração de multiplos tabuleiros

Para gerar multiplos tabuleiros com dimensões e número de elementos distintos requer utilizar os predicados do ficheiro `statistics.pl` que foi consultado pelo `main.pl`.  
Os principais predicados deste ficheiro são: 

```prolog 
dimensional_statistics(+[BoundSize, CeilSize], +Distincts).
distincts_statistics(+Size, +[BoundDistincts, CeilDistincts]). 
deterministic_board_solve(+Side). 
all_deterministic_boards. 
```


- O predicado `dimensional_statistics/3` gera tabuleiros aleatórios com lados dentro do intervalo [BoundSize, CeilSize]. Todas as soluções são apresentadas com estatísticas. 
- `distincts_statistics/3` gera tabuleiros aleatórios com número de elementos distintos por linha/coluna dentro do intervalo [BoundDistincts, CeilDistincts], com todas as soluções disponibilizadas com estatísticas.  
- `deterministic_board_solve/1` seleciona o board do predicado `deterministic_board/3` cujo o tamanho do lado é igual a `Side`. 
- `all_deterministic_boards/0` resolve todos os boards declarados em `deterministic_board/3`.  

## Authors 
- [Alexandre Abreu](https://github.com/a3brx)
- [Juliane Maruabyashi](https://github.com/jumaruba)
