### Explicação da Estrutura

#### Tabela `accounts`
- **Campos**:
  - `id`: Chave primária autoincrementada.
  - `name`: Nome único da conta (3 a 50 caracteres).
  - `type`: Restrito a 'bank' ou 'cash'.
  - `initial_balance`: Saldo inicial, padrão 0.0.
  - `created_at`: Data de criação para rastreamento.
- **Restrições**: Nome único e tipo válido.

#### Tabela `categories`
- **Campos**:
  - `id`: Chave primária autoincrementada.
  - `name`: Nome único da categoria (2 a 30 caracteres).
  - `is_default`: Flag para diferenciar categorias padrão (1) de personalizadas (0).
  - `created_at`: Data de criação.
- **Restrições**: Nome único e limite de caracteres.

#### Tabela `transactions`
- **Campos**:
  - `id`: Chave primária autoincrementada.
  - `title`: Título da transação (obrigatório).
  - `amount`: Valor, maior que zero.
  - `date`: Data da transação, não futura.
  - `account_id`: Referência à conta associada.
  - `category_id`: Referência à categoria associada.
  - `type`: 'income' (receita) ou 'expense' (despesa).
  - `description`: Opcional, pode ser nulo.
  - `created_at`: Data de criação.
  - `updated_at`: Data de atualização (nulo até ser editado).
- **Restrições**: 
  - Chaves estrangeiras para `accounts` e `categories` com `ON DELETE RESTRICT` (impede exclusão se houver transações associadas).
  - Validações em `amount`, `date` e `type`.

#### Tabela `change_log`
- **Campos**:
  - `id`: Chave primária autoincrementada.
  - `action`: Tipo de ação ('create', 'update', 'delete').
  - `entity_type`: Tipo de entidade afetada ('transaction', 'account', 'category').
  - `entity_id`: ID da entidade modificada.
  - `timestamp`: Data e hora da alteração.
  - `details`: Informações adicionais (opcional).
- **Restrições**: Validações em `action` e `entity_type`.

#### Dados Iniciais
- **Conta Padrão**: 'Dinheiro' é inserida automaticamente.
- **Categorias Padrão**: As categorias sugeridas (mais 'Outros') são inseridas com `is_default = 1`.

#### Índices
- Criados para consultas frequentes (ex.: relatórios por data, conta ou categoria) e log de alterações, otimizando a performance.

---

### Considerações
- **Limite de 10.000 Transações**: Não é imposto diretamente no SQL, mas pode ser controlado na lógica do aplicativo.
- **Exportação/Importação JSON**: O SQLite suporta isso via consultas que podem ser serializadas em JSON (ex.: usando `json_group_array` ou bibliotecas no Rust).
- **Restrição de Edição no Mesmo Dia**: O campo `updated_at` ajuda a rastrear isso, mas a lógica de bloqueio deve ser implementada no aplicativo.
- **Criptografia de Exportação**: Não é gerenciada no SQLite, mas pode ser feita no nível do aplicativo antes de salvar o JSON.

---

Esse comando SQL cria a estrutura inicial do banco de dados do **Limoney**, pronta para ser usada com SQLite no Tauri. Se precisar de ajustes (ex.: mais campos, índices adicionais) ou ajuda para integrar isso ao Rust/Svelte, é só me avisar! Qual o próximo passo que você quer dar?