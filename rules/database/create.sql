-- Criação da tabela de contas (accounts)
CREATE TABLE accounts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE CHECK(length(name) >= 3 AND length(name) <= 50),
    type TEXT NOT NULL CHECK(type IN ('bank', 'cash')), -- 'bank' para contas bancárias, 'cash' para dinheiro em espécie
    initial_balance REAL NOT NULL DEFAULT 0.0, -- Saldo inicial da conta
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Criação da tabela de categorias (categories)
CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE CHECK(length(name) >= 2 AND length(name) <= 30),
    is_default INTEGER NOT NULL DEFAULT 0 CHECK(is_default IN (0, 1)), -- 1 para categorias padrão, 0 para personalizadas
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Criação da tabela de transações (transactions)
CREATE TABLE transactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    amount REAL NOT NULL CHECK(amount > 0), -- Valor deve ser maior que zero
    date DATETIME NOT NULL CHECK(date <= CURRENT_TIMESTAMP), -- Data não pode ser futura
    account_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('income', 'expense')), -- 'income' para receita, 'expense' para despesa
    description TEXT, -- Campo opcional
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT NULL, -- Para rastrear edições no mesmo dia
    FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE RESTRICT,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT
);

-- Criação da tabela de log de alterações (change_log)
CREATE TABLE change_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    action TEXT NOT NULL CHECK(action IN ('create', 'update', 'delete')),
    entity_type TEXT NOT NULL CHECK(entity_type IN ('transaction', 'account', 'category')),
    entity_id INTEGER NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    details TEXT -- Detalhes adicionais da alteração, opcional
);

-- Inserção da conta padrão 'Dinheiro'
INSERT INTO accounts (name, type, initial_balance) 
VALUES ('Dinheiro', 'cash', 0.0);

-- Inserção das categorias padrão
INSERT INTO categories (name, is_default) VALUES 
('Alimentação', 1),
('Moradia', 1),
('Transporte', 1),
('Saúde', 1),
('Lazer', 1),
('Educação', 1),
('Outros', 1); -- Categoria padrão para exclusões

-- Índices para melhorar performance em consultas frequentes
CREATE INDEX idx_transactions_date ON transactions(date);
CREATE INDEX idx_transactions_account_id ON transactions(account_id);
CREATE INDEX idx_transactions_category_id ON transactions(category_id);
CREATE INDEX idx_change_log_timestamp ON change_log(timestamp);