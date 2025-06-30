library(readr)
library(nortest)
library(moments)

setwd("C:/spring_modulith-main/Results/LoadTests")


# Carregar e visualizar os dados
ModulithAsyncPOSTObsv <- read_csv("ModulithAsyncPOSTObsv.csv")
View(ModulithAsyncPOSTObsv)

ModulithSyncGET <- read_csv("ModulithSyncGET.csv")
View(ModulithSyncGET)

ModulithAsyncGETObsv <- read_csv("ModulithAsyncGETObsv.csv")
View(ModulithAsyncGETObsv)

ModulithAsyncGET <- read_csv("ModulithAsyncGET.csv")
View(ModulithAsyncGET)

ModulithAsyncPOST <- read_csv("ModulithAsyncPOST.csv")
View(ModulithAsyncPOST)

ModulithSyncGETObsv <- read_csv("ModulithSyncGETObsv.csv")
View(ModulithSyncGETObsv)

ModulithSyncPOST <- read_csv("ModulithSyncPOST.csv")
View(ModulithSyncPOST)

ModulithSyncPOSTObsv <- read_csv("ModulithSyncPOSTObsv.csv")
View(ModulithSyncPOSTObsv)

MonolithGET2 <- read_csv("MonolithGET2.csv")
View(MonolithGET2)

MonolithGETObsv <- read_csv("MonolithGETObsv.csv")
View(MonolithGETObsv)

MonolithPOST <- read_csv("MonolithPOST.csv")
View(MonolithPOST)

MonolithPOSTObsv <- read.csv("MonolithPOSTObsv.csv")
View(MonolithPOSTObsv)

# Extrair tempos de resposta
time_async_post_obs <- ModulithAsyncPOSTObsv$elapsed
time_sync_get <- ModulithSyncGET$elapsed
time_async_get_obs <- ModulithAsyncGETObsv$elapsed
time_async_get <- ModulithAsyncGET$elapsed
time_async_post <- ModulithAsyncPOST$elapsed
time_sync_get_obs <- ModulithSyncGETObsv$elapsed
time_sync_post <- ModulithSyncPOST$elapsed
time_sync_post_obs <- ModulithSyncPOSTObsv$elapsed
time_mono_get <- MonolithGET2$elapsed
time_mono_get_obs <- MonolithGETObsv$elapsed
time_mono_post <- MonolithPOST$elapsed
time_mono_post_obs <- MonolithPOSTObsv$elapsed

# Cálculo de médias
mean(time_async_post_obs)
mean(time_sync_get)
mean(time_async_get_obs)
mean(time_async_get)
mean(time_async_post)
mean(time_sync_get_obs)
mean(time_sync_post)
mean(time_sync_post_obs)
mean(time_mono_get)
mean(time_mono_get_obs)
mean(time_mono_post)
mean(time_mono_post_obs)

# Cálculo de medianas
median(time_async_post_obs)
median(time_sync_get)
median(time_async_get_obs)
median(time_async_get)
median(time_async_post)
median(time_sync_get_obs)
median(time_sync_post)
median(time_sync_post_obs)
median(time_mono_get)
median(time_mono_get_obs)
median(time_mono_post)
median(time_mono_post_obs)

# Cálculo de máximos
max(time_async_post_obs)
max(time_sync_get)
max(time_async_get_obs)
max(time_async_get)
max(time_async_post)
max(time_sync_get_obs)
max(time_sync_post)
max(time_sync_post_obs)
max(time_mono_get)
max(time_mono_get_obs)
max(time_mono_post)
max(time_mono_post_obs)

# Testes de normalidade
lillie.test(time_async_post_obs)
lillie.test(time_sync_get)
lillie.test(time_async_get_obs)
lillie.test(time_async_get)
lillie.test(time_async_post)
lillie.test(time_sync_get_obs)
lillie.test(time_sync_post)
lillie.test(time_sync_post_obs)
lillie.test(time_mono_get)
lillie.test(time_mono_get_obs)
lillie.test(time_mono_post)
lillie.test(time_mono_post_obs)

# Coeficiente de assimetria
skewness(time_async_post_obs)
skewness(time_sync_get)
skewness(time_async_get_obs)
skewness(time_async_get)
skewness(time_async_post)
skewness(time_sync_get_obs)
skewness(time_sync_post)
skewness(time_sync_post_obs)
skewness(time_mono_get)
skewness(time_mono_get_obs)
skewness(time_mono_post)
skewness(time_mono_post_obs)

# Testes de hipótese para overhead da observabilidade
# Hipótese nula (H0): Não há diferença significativa com/sem observabilidade
# Hipótese alternativa (H1): Há diferença significativa com/sem observabilidade

# GET - Monolith
wilcox.test(time_mono_get_obs, time_mono_get, paired=FALSE)

# POST - Monolith
wilcox.test(time_mono_post_obs, time_mono_post, paired=FALSE)

# POST - Modulith Síncrono
wilcox.test(time_sync_post_obs, time_sync_post, paired=FALSE)

# POST - Modulith Assíncrono
wilcox.test(time_async_post_obs, time_async_post, paired=FALSE)

# GET - Modulith Síncrono
wilcox.test(time_sync_get_obs, time_sync_get, paired=FALSE)

# GET - Modulith Assíncrono
wilcox.test(time_async_get_obs, time_async_get, paired=FALSE)

# Gráficos de barras para comparação

# POST - Comparação com/sem observabilidade
dados_post <- c(
  mean(time_mono_post),
  mean(time_mono_post_obs),
  mean(time_sync_post),
  mean(time_sync_post_obs),
  mean(time_async_post),
  mean(time_async_post_obs)
)

categorias_post <- c(
  "Monolith\n(sem obs)",
  "Monolith\n(com obs)",
  "Modulith Sync\n(sem obs)",
  "Modulith Sync\n(com obs)",
  "Modulith Async\n(sem obs)",
  "Modulith Async\n(com obs)"
)

cores_post <- c("orange", "darkorange", "blue", "darkblue", "green", "darkgreen")

grafico_post <- barplot(dados_post, names.arg = categorias_post, 
                       col = cores_post, main = "Tempo Medio POST (ms)",
                       ylab = "Tempo (ms)", las = 2, cex.names = 0.8,
                       ylim = c(0, max(dados_post)*1.2))

text(x = grafico_post, y = dados_post, labels = round(dados_post, 2), pos = 3, col = "black")

# GET - Comparação com/sem observabilidade
dados_get <- c(
  mean(time_mono_get),
  mean(time_mono_get_obs),
  mean(time_sync_get),
  mean(time_sync_get_obs),
  mean(time_async_get),
  mean(time_async_get_obs)
)

categorias_get <- c(
  "Monolith\n(sem obs)",
  "Monolith\n(com obs)",
  "Modulith Sync\n(sem obs)",
  "Modulith Sync\n(com obs)",
  "Modulith Async\n(sem obs)",
  "Modulith Async\n(com obs)"
)

cores_get <- c("orange", "darkorange", "blue", "darkblue", "green", "darkgreen")

grafico_get <- barplot(dados_get, names.arg = categorias_get, 
                      col = cores_get, main = "Tempo Medio GET (ms)",
                      ylab = "Tempo (ms)", las = 2, cex.names = 0.8,
                      ylim = c(0, max(dados_get)*1.2))

text(x = grafico_get, y = dados_get, labels = round(dados_get, 2), pos = 3, col = "black")

# Cálculo do overhead percentual
overhead_get_mono <- (mean(time_mono_get_obs) - mean(time_mono_get)) / mean(time_mono_get) * 100
overhead_post_mono <- (mean(time_mono_post_obs) - mean(time_mono_post)) / mean(time_mono_post) * 100
overhead_post_sync <- (mean(time_sync_post_obs) - mean(time_sync_post)) / mean(time_sync_post) * 100
overhead_post_async <- (mean(time_async_post_obs) - mean(time_async_post)) / mean(time_async_post) * 100
overhead_get_sync <- (mean(time_sync_get_obs) - mean(time_sync_get)) / mean(time_sync_get) * 100
overhead_get_async <- (mean(time_async_get_obs) - mean(time_async_get)) / mean(time_async_get) * 100

dados_overhead <- c(
  overhead_get_mono,
  overhead_post_mono,
  overhead_get_sync,
  overhead_post_sync,
  overhead_get_async,
  overhead_post_async
)

categorias_overhead <- c(
  "GET Monolith",
  "POST Monolith",
  "GET Sync",
  "POST Sync",
  "GET Async",
  "POST Async"
)

grafico_overhead <- barplot(dados_overhead, names.arg = categorias_overhead,
                           col = rep(c("orange", "blue", "green"), each=2),
                           main = "Overhead da Observabilidade (%)",
                           ylab = "Aumento percentual", las = 2)

text(x = grafico_overhead, y = dados_overhead,
     labels = paste0(round(dados_overhead, 1), "%"), pos = 3, col = "black")






# Dados throughtput GET
throughput_get <- c(305.03, 306.44,   # Monolith (sem, com)
                    307.47, 306.78,    # Modulith Sync (sem, com)
                    307.94, 305.84)    # Modulith Async (sem, com)

categorias_get <- c("Monolith\n(sem obs)", "Monolith\n(com obs)",
                    "Modulith Sync\n(sem obs)", "Modulith Sync\n(com obs)",
                    "Modulith Async\n(sem obs)", "Modulith Async\n(com obs)")

# Cores (laranja para Monolith, azul para Sync, verde para Async)
cores_get <- c("orange", "darkorange",
               "blue", "darkblue",
               "green", "darkgreen")

# Plot
grafico_get <- barplot(throughput_get,
                       names.arg = categorias_get,
                       col = cores_get,
                       main = "THROUGHPUT - REQUESTS GET",
                       ylab = "Requests/segundo",
                       ylim = c(0, 350),
                       las = 2,
                       cex.names = 0.8)

# Valores
text(x = grafico_get, y = throughput_get + 1,
     labels = throughput_get, pos = 3, col = "black")

# Dados throughtput POST
throughput_post <- c(307.03, 306.12,   # Monolith (sem, com)
                     306.22, 306.53,    # Modulith Sync (sem, com)
                     306.28, 307.47)    # Modulith Async (sem, com)

categorias_post <- c("Monolith\n(sem obs)", "Monolith\n(com obs)",
                    "Modulith Sync\n(sem obs)", "Modulith Sync\n(com obs)",
                    "Modulith Async\n(sem obs)", "Modulith Async\n(com obs)")

# Cores (laranja para Monolith, azul para Sync, verde para Async)
cores_post <- c("orange", "darkorange",
               "blue", "darkblue",
               "green", "darkgreen")

# Plot
grafico_get <- barplot(throughput_get,
                       names.arg = categorias_get,
                       col = cores_get,
                       main = "THROUGHPUT - REQUESTS POST",
                       ylab = "Requests/segundo",
                       ylim = c(0, 350),
                       las = 2,
                       cex.names = 0.8)

# Valores
text(x = grafico_post, y = throughput_post + 1,
     labels = throughput_post, pos = 3, col = "black")
