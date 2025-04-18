# Imagem base
FROM ruby:3.2.2

# argumentos no uso da imagem
ARG RAILS_ENV

# Instalar dependências do sistema
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn

ENV RAILS_ENV=${RAILS_ENV}

# Configurar o diretório de trabalho
WORKDIR /app

# Adicionar Gemfile e instalar dependências
COPY Gemfile* /app/
RUN bundle install

# Copiar o código da aplicação
COPY . /app

# Expor a porta padrão do Rails
EXPOSE 3000

# Comando de entrada
# CMD ["rails", "server", "-b", "0.0.0.0"]
