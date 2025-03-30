### 1. Cadastro de Transações
- O usuário pode registrar transações de receita (créditos) e despesa (débitos), armazenadas localmente no SQLite.
- **Campos Necessários**: Título, Valor, Data, Conta, Categoria, Tipo (Receita ou Despesa), e um ID único gerado automaticamente para cada transação.
- **Campos Opcionais**: Descrição (pode ser deixada em branco ou nula).
- **Regras**:
  - O valor da transação deve ser maior que zero.
  - A data da transação não pode ser posterior à data atual do sistema; se permitido, tais transações não afetam o saldo até a data chegar.
  - O saldo da conta associada à transação é atualizado automaticamente após cada registro no SQLite, somando para receitas e subtraindo para despesas.
  - Transações só podem ser editadas ou excluídas no mesmo dia do registro, salvo exceções definidas pelo usuário (ex.: opção explícita para alterações retroativas).

---

### 2. Categoria de Gastos
- O usuário pode criar, editar e excluir categorias personalizadas para classificar as despesas, salvas no SQLite.
- **Categorias Padrão**: O sistema inicia com categorias sugeridas (Alimentação, Moradia, Transporte, Saúde, Lazer, Educação), que não podem ser excluídas, apenas renomeadas.
- **Regras**:
  - Cada transação deve estar vinculada a uma categoria existente no momento do registro.
  - Se uma categoria personalizada for excluída, as transações associadas serão movidas para uma categoria padrão 'Outros', criada automaticamente se não existir.
  - O usuário pode criar até 50 categorias personalizadas.
  - O nome da categoria deve ser único e ter entre 2 e 30 caracteres.

---

### 3. Relatórios e Gráficos
- O sistema gera relatórios de receitas e despesas por períodos selecionáveis (dia, semana, mês, ano), baseados nos dados do SQLite.
- O usuário pode visualizar gráficos de gastos por categoria, com filtros por período e conta.
- **Regras**:
  - Relatórios gerados são armazenados temporariamente no sistema por 24 horas para acesso rápido, salvo exportação.
  - Os relatórios podem ser exportados em PDF ou CSV, com arquivos gerados localmente e criptografados ou protegidos por senha opcional (definida pelo usuário).

---

### 4. Cadastro de Contas e Pagamentos
- O usuário pode cadastrar contas bancárias ou dinheiro em espécie, armazenadas no SQLite.
- **Regras**:
  - Uma conta padrão 'Dinheiro' é criada automaticamente ao iniciar o sistema pela primeira vez.
  - O nome da conta deve ser único e ter entre 3 e 50 caracteres.
  - Cada transação deve ser associada a uma conta específica.
  - Uma conta só pode ser excluída se não houver transações associadas ou se todas as transações forem movidas para outra conta (ex.: 'Dinheiro').
  - Cada conta pode ter um saldo inicial definido pelo usuário ao criá-la, registrado no SQLite.

---

### 5. Exportar e Importar
- O usuário pode exportar suas informações (transações, categorias e contas, com metadados como data de exportação e versão do sistema) em um arquivo JSON local.
- O usuário pode importar suas informações a partir de um arquivo JSON local.
- **Regras**:
  - O arquivo JSON importado deve seguir um esquema predefinido, e dados inválidos serão rejeitados com mensagens de erro específicas exibidas ao usuário.
  - Na importação, IDs existentes serão preservados, e novos IDs serão gerados para evitar duplicatas; o usuário pode escolher sobrescrever ou mesclar os dados atuais.
  - Antes de importar dados, o sistema gera um backup automático em JSON, salvo localmente com um nome único (ex.: `limoney_backup_YYYYMMDD.json`).

---

### Regras Gerais
- **Armazenamento Local**: Todos os dados (transações, categorias, contas) são salvos em um banco SQLite local, acessível apenas no dispositivo do usuário.
- **Histórico de Alterações**: O sistema mantém um log básico de alterações (criação/exclusão de transações, contas, categorias) com data e hora, armazenado no SQLite, para auditoria local.
- **Limite de Dados**: O sistema suporta até 10.000 transações antes de recomendar ao usuário arquivar ou otimizar os dados (ex.: exportar e limpar registros antigos).
- **Notificações**: O usuário é notificado localmente sobre ações críticas (ex.: exclusão de conta/categoria, importação de dados), exibidas na interface do aplicativo.

---

### Análise dos Ajustes
- **SQLite e JSON**: A escolha por um sistema local elimina a necessidade de autenticação, mas reforça a importância de backups (regra de importação) e segurança nos arquivos exportados (criptografia opcional).
- **Validações e Limites**: Regras como valores > 0, limite de categorias e tamanho de nomes previnem inconsistências e abusos no uso local.
- **Consistência**: Mover transações para 'Outros' ou 'Dinheiro' ao excluir categorias/contas mantém os dados íntegros.
- **Usabilidade**: Contas e categorias padrão, períodos flexíveis nos relatórios e notificações locais tornam o sistema mais amigável e previsível.
- **Escalabilidade**: O limite de 10.000 transações e o log de alterações preparam o Limoney para uso prolongado sem degradação de performance.