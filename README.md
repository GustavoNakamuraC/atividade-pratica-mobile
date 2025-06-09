# Painel de Ativos Digitais - Aplicativo Flutter  

Este aplicativo desenvolvido em Flutter consome a API do CoinMarketCap para apresentar informações sobre criptomoedas.  

## Como Configurar e Rodar  

1. **Baixar o projeto:**  

```bash
git clone <url_do_repositorio>  
cd atividade_pratica_coin_master  
```  

2. **Instalar os pacotes necessários:**  

```bash
flutter pub get  
```  

3. **Iniciar o aplicativo (versão web com CORS desativado):**  

Para testar no navegador evitando problemas com CORS durante o desenvolvimento:  

```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"  
```  

**Atenção:** Desativar as restrições de segurança só é indicado para ambiente de desenvolvimento. Na versão final, o servidor deve estar configurado para gerenciar corretamente as políticas CORS.  

4. **Rodar em outras plataformas (opcional):**  

Para dispositivos móveis:  

```bash
flutter run  
```  

## Organização do Código  

Principais pastas e arquivos dentro de `lib`:  

```
lib/  
├── configs/  
│   └── service_configuration.dart  
├── core/  
│   ├── library/  
│   │   └── application_settings.dart  
│   └── service/  
│       └── network_client.dart  
├── data/  
│   ├── datasources/  
│   │   └── market_data_provider.dart  
│   └── repositories/  
│       └── digital_asset_repository.dart  
├── domain/  
│   ├── entities/  
│   │   └── digital_asset_model.dart  
│   └── repositories/  
│       └── i_digital_asset_repository.dart  
├── digital_asset_tracker.dart  
└── ui/  
    ├── pages/  
    │   └── digital_assets_dashboard.dart  
    └── view_models/  
        └── digital_currency_controller.dart  
```  

## ✨ Principais Recursos  

- ✔️ Visualização das principais criptomoedas  
- ✔️ Pesquisa por códigos específicos (ex: BTC, ETH)  
- ✔️ Valores convertidos para USD e BRL  
- ✔️ Design adaptável  
- ✔️ Indicador de carregamento e tratamento de falhas  
- ✔️ Atualização arrastando a tela  
- ✔️ Informações detalhadas de cada moeda  

## 🔐 Como Configurar a API  

### Adquirindo sua chave pessoal  

**AVISO:** O projeto vem com uma chave de teste que pode ter restrições. Para acesso completo, obtenha sua própria chave:  

1. **Acesse o CoinMarketCap:**  
   - Visite [https://coinmarketcap.com/api/](https://coinmarketcap.com/api/)  
   - Selecione "Get Your API Key Now"  

2. **Registre-se gratuitamente:**  
   - Complete o cadastro com e-mail  
   - Valide sua conta  
   - Acesse o painel de controle  

3. **Obtenha sua chave:**  
   - No painel, localize sua API Key  
   - Copie o código (formato: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`)  

### Inserindo sua chave no projeto  

**Substitua a chave de exemplo pela sua:**  

1. Abra `lib/configs/api_config.dart`  
2. Encontre a linha:  
```dart
static const String apiKey = '31322d00-32f2-4a36-9749-f8133b5661a2';  
```  
3. Substitua pelo seu código:  
```dart
static const String apiKey = 'COLE_SUA_CHAVE_AQUI';  
```  

### Opções de planos  

- **Básico (Grátis):** 333 consultas/dia, informações básicas  
- **Intermediário ($29/mês):** 3.333 consultas/dia, mais recursos  
- **Avançado ($79/mês):** 10.000 consultas/dia, histórico completo  
- **Empresarial ($249/mês):** 33.333 consultas/dia, suporte dedicado  

**Recomendações para produção:**  
1. Armazenar chaves em variáveis de ambiente  
2. Criar um servidor intermediário  
3. Nunca expor chaves no lado do cliente  
4. Escolher plano conforme necessidade  

## 🔧 Resolução de Problemas  

### Erro: "ClientException: Failed to fetch"  

Indica conflito com CORS. Use o comando correto:  

```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"  
```  

### Erro: "No device found"  

Verifique se o navegador está instalado e execute:  

```bash
flutter devices  
```  

### Dependências com conflitos  

Limpe e reinstale:  

```bash
flutter clean  
flutter pub get  
```  

## 💻 Tecnologias Aplicadas  

- **Flutter** - Plataforma de desenvolvimento  
- **Provider** - Controle de estado  
- **HTTP** - Comunicação com APIs  
- **Intl** - Formatação de valores  
- **CoinMarketCap API** - Fonte de dados