dados <- read.csv("dadosPacientes2021.csv")

dados[dados == "Mascuino"] <- "Masculino"

check_20 <- grepl(("2020"), dados$data_resultado_exame, fixed = TRUE)
check_21 <- grepl(("2021"), dados$data_resultado_exame, fixed = TRUE)

dados <- subset(dados, check_20 == TRUE | check_21 == TRUE)
dados <- subset(dados, idade > 0 & idade < 120)

grid <- grid(nx = NA, ny = NULL, lty = 2, col = "gray", lwd = 1)

dados.craibas <- subset(dados, municipio_residencia == "Craíbas")

#############################################################

#GRÁFICO DOS ÓBITOS DE CRAÍBAS POR SEXO E IDADE

obitos.craibas <- subset(dados.craibas, situacao_atual == "Óbito")
obitos.craibas.idade <- cut(obitos.craibas$idade, seq(0, 100, by = 10))

plot.obitos.sexo <- table(obitos.craibas$sexo, obitos.craibas.idade)

lim_idade <- c("0 - 10", "10 - 20", "20 - 30", "30 - 40", "40 - 50", "50 - 60", 
               "60 - 70", "70 - 80", "80 - 90", "90 - 100")

gb_craibas <- barplot(plot.obitos.sexo, beside = TRUE, add = TRUE,
        col = c("mistyrose2", "lightskyblue1"), names.arg = lim_idade,
        main = "GRÁFICO DE ÓBITOS POR SEXO E IDADE EM CRAÍBAS", legend = TRUE,
        args.legend = list(x = 10, y = 4, cex = 0.8, text.font = 2, 
                           bg = "ghostwhite"),
        xlab = "Idade (em anos)", ylab= "Número de Óbitos")
          
############################################################# 

#GRÁFICO DE CONTAMINAÇÕES EM CRAÍBAS POR SEXO E IDADE

dados.craibas.idade <- table(dados.craibas$idade)

craibas_idade <- cut(dados.craibas$idade, seq(0, 100, by = 10))

casos.confirmados <- subset(dados.craibas, classificacao == "Confirmado")

casos.craibas <- table(casos.confirmados$sexo, craibas_idade) 

gb_craibas2 <- barplot(casos.craibas, beside = TRUE, add = TRUE,
        col = c("mistyrose2", "lightskyblue1"), names.arg = lim_idade,
        xlab = "Idade (em anos)", ylab = "Número de Contaminações",
        main = "GRÁFICO DE CONTAMINAÇÕES POR SEXO E IDADE EM CRAÍBAS",
        legend = TRUE, args.legend = list(x = 30, y = 130, cex = 0.8, text.font = 2, 
                                           bg = "ghostwhite"))

######################################################################
