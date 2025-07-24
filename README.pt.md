# 🏙️ Análise SQL – Mercado Imobiliário de São Paulo (Zap Imóveis)

## 📌 Objetivo

Este projeto tem como objetivo realizar uma análise exploratória de dados do mercado imobiliário de São Paulo, utilizando apenas **SQL puro**, com foco em:
- Entender padrões de preços;
- Identificar variações sazonais;
- Investigar o impacto de variáveis como tamanho, quartos e vagas; e
- Mapear os bairros mais valorizados e acessíveis.

A proposta é extrair **insights acionáveis** a partir de uma base **real** do portal Zap Imóveis, evidenciando como SQL pode ser usado para guiar decisões de negócio.

---

## 🧠 Por que este projeto?

- ⚡ **Análise prática com base real**: optei por uma base de dados pública e real, porque acredito que análise de dados só faz sentido se gerar ação e impacto prático. É um tema próximo da realidade de quem atua com BI, marketing, precificação ou expansão territorial.
- 🎯 **Foco em SQL para decisões rápidas**: essa é uma EDA mais direta, com a clareza de que SQL é excelente para consultas rápidas, pré-processamentos e cálculos de negócio. Para análises mais profundas, tenho preferido usar Python (veja meu projeto complementar de EDA com Python [aqui](https://github.com/arthurcurrycb/mba-admissions-eda/))
- 🧱 **Cobertura técnica**: utilizei CTEs, Window Functions e criei uma `VIEW` filtrando outliers com percentis. Isso torna a análise mais limpa e melhora a representatividade estatística das métricas.
- 🗣️ **Documentação comentada**: comentei os códigos e resultados diretamente no script SQL. Isso contribui para comunicação assíncrona, gestão do conhecimento e ajuda no meu próprio processo analítico.

---

## 🗃️ Fonte dos dados

- Portal: [Zap Imóveis](https://www.zapimoveis.com.br/)
- Dataset: [Kaggle – Discover São Paulo Apartment Prices Insights](https://www.kaggle.com/datasets/marcelobatalhah/discover-so-paulo-apartment-prices-insights) (base pública, com dados anonimizados de 27 mil apartamentos à venda em SP)

---

## 🔍 Etapas do projeto

1. **Inspeção e entendimento dos dados**
2. **Verificação de valores nulos**
3. **Identificação e exclusão de outliers com percentis**
4. **Criação de `VIEW` para facilitar reuso**
5. **Exploração univariada e bivariada**
6. **Criação de faixas (área) e rankings (preço por bairro)**
7. **Agregações por ano, mês e bairro**
8. **Conclusão**

---

## 📈 Principais descobertas

- O preço médio e o preço por m² atingiram o pico em **2021** e vêm caindo desde então.
- Em **2024**, os valores caíram aproximadamente **18%** em relação ao pico.
- Há **sazonalidade nos preços**, com valores mais baixos em **abril** e mais altos em **fevereiro, novembro e dezembro**.
- Os **bairros mais valorizados** foram: Ibirapuera, Jardim América e Jardim Panorama.
- Os **bairros mais acessíveis** incluíram Guapira, Jardim Patente e Jaraguá.
- Apartamentos pequenos (< 50m²) têm preço médio de **R$ 587 mil**, podendo ultrapassar **R$ 2 milhões**.
- Tamanho, número de quartos, banheiros e vagas parecem ter relação direta com o preço – insights compatíveis com o senso comum, agora validados com dados.

---

## 🚀 Próximos passos

- Calcular **coeficiente de correlação** entre variáveis numéricas e o preço.
- Evoluir para um **modelo preditivo de preço** usando Python e regressão.
- Unir com dados externos (como renda per capita por bairro, mobilidade, segurança) e de outros sites para análises mais robustas.

---

## 🧩 Tecnologias utilizadas

- PostgreSQL (via DBeaver)
- SQL (CTEs, Window Functions, Views, agregações, filtros por percentil)
- GitHub para versionamento e documentação

---

## 🧑‍💻 Autor

**Arthur Curry**  
Analista de Dados com background em Growth e RevOps  
[LinkedIn](https://www.linkedin.com/in/arthurcurrycb) • [GitHub](https://github.com/arthurcurrycb)