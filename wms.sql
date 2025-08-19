create database wms_etec;

CREATE TABLE Fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    unidade_medida VARCHAR(20), -- ex: kg, caixa, pct
    preco_compra DECIMAL(10,2),
    preco_venda DECIMAL(10,2),
    id_fornecedor INT,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);

CREATE TABLE Endereco_Fisico (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    setor VARCHAR(50),
    corredor VARCHAR(50),
    prateleira VARCHAR(50)
);

CREATE TABLE Estoque (
    id_estoque INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    id_endereco INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto),
    FOREIGN KEY (id_endereco) REFERENCES Endereco_Fisico(id_endereco)
);

CREATE TABLE Entrada_Produto (
    id_entrada INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    id_fornecedor INT NOT NULL,
    quantidade INT NOT NULL,
    data_entrada DATE NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(200)
);

CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL,
    status ENUM('PENDENTE','FATURADO','ENVIADO','CANCELADO') DEFAULT 'PENDENTE',
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Item_Pedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

CREATE TABLE Faturamento (
    id_fatura INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    data_faturamento DATE NOT NULL,
    valor_total DECIMAL(12,2) NOT NULL,
    status ENUM('PENDENTE','PAGO','ATRASADO') DEFAULT 'PENDENTE',
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);
