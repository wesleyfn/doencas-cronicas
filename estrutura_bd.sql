-- object: public.Prontuario | type: TABLE --

CREATE TABLE Prontuario (
    id_prontuario SMALLINT NOT NULL,
    id_paciente_Paciente SMALLINT NOT NULL,
    id_check_in_Check_in SMALLINT NOT NULL,
    PRIMARY KEY (id_prontuario)
);

-- object: public.Check_in | type: TABLE --

CREATE TABLE Check_in (
    id_check_in SMALLINT NOT NULL,
    data_Check_in TIME NOT NULL,
    PRIMARY KEY (id_check_in)
);

ALTER TABLE Check_in
MODIFY COLUMN data_Check_in DATE;


-- object: public.Pessoa | type: TABLE --

CREATE TABLE Pessoa (
    id_pessoa SMALLINT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    CPF NUMERIC(11) NOT NULL,
    data_nascimento TIME NOT NULL,
    sexo VARCHAR(255) NOT NULL,
    telefone NUMERIC(10),
    PRIMARY KEY (id_pessoa)
);

-- object: public.Paciente | type: TABLE --

CREATE TABLE Paciente (
    id_paciente SMALLINT NOT NULL,
    id_pessoa SMALLINT NOT NULL,
    PRIMARY KEY (id_paciente),
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- object: public.Sintoma | type: TABLE --

CREATE TABLE Sintoma (
    id_sintoma SMALLINT NOT NULL,
    nome_sintoma VARCHAR(255) NOT NULL,
    descricao_sintoma VARCHAR(255) NOT NULL,
    gravidade_sintoma SMALLINT NOT NULL,
    PRIMARY KEY (id_sintoma)
);

-- object: public.Condicao | type: TABLE --

CREATE TABLE Condicao (
    id_condicao SMALLINT NOT NULL,
    nome_condicao VARCHAR(255) NOT NULL,
    descricao_condicao VARCHAR(255),
    gravidade_condicao SMALLINT NOT NULL,
    PRIMARY KEY (id_condicao)
);

-- object: public.Tratamento | type: TABLE --

CREATE TABLE Tratamento (
    id_tratamento SMALLINT NOT NULL,
    nome_tratamento VARCHAR(255) NOT NULL,
    descricao_tratamento VARCHAR(255) NOT NULL,
    dosagem_tratamento VARCHAR(255),
    PRIMARY KEY (id_tratamento)
);

-- object: Prontuario_fk | type: CONSTRAINT --
ALTER TABLE Prontuario ADD CONSTRAINT Prontuario_fk FOREIGN KEY (id_paciente_Paciente)
REFERENCES Paciente(id_paciente) ON DELETE CASCADE ON UPDATE CASCADE;

-- object: Prontuario_fk_1 | type: CONSTRAINT --
ALTER TABLE Prontuario ADD CONSTRAINT Prontuario_fk_1 FOREIGN KEY (id_check_in_Check_in)
REFERENCES Check_in(id_check_in) ON DELETE CASCADE ON UPDATE CASCADE;

-- object: many_Prontuario_has_many_Sintoma | type: TABLE --

CREATE TABLE many_Prontuario_has_many_Sintoma (
    id_prontuario_Prontuario SMALLINT NOT NULL,
    id_sintoma_Sintoma SMALLINT NOT NULL,
    PRIMARY KEY (id_prontuario_Prontuario, id_sintoma_Sintoma)
);

-- object: Prontuario_fk_2 | type: CONSTRAINT --
ALTER TABLE many_Prontuario_has_many_Sintoma ADD CONSTRAINT Prontuario_fk_2 FOREIGN KEY (id_prontuario_Prontuario)
REFERENCES Prontuario(id_prontuario) ON DELETE CASCADE ON UPDATE CASCADE;

-- object: Sintoma_fk | type: CONSTRAINT --
ALTER TABLE many_Prontuario_has_many_Sintoma ADD CONSTRAINT Sintoma_fk FOREIGN KEY (id_sintoma_Sintoma)
REFERENCES Sintoma(id_sintoma) ON DELETE CASCADE ON UPDATE CASCADE;

-- object: many_Prontuario_has_many_Tratamento | type: TABLE --

CREATE TABLE many_Prontuario_has_many_Tratamento (
    id_prontuario_Prontuario SMALLINT NOT NULL,
    id_tratamento_Tratamento SMALLINT NOT NULL,
    PRIMARY KEY (id_prontuario_Prontuario, id_tratamento_Tratamento)
);

-- object: Prontuario_fk_3 | type: CONSTRAINT --
ALTER TABLE many_Prontuario_has_many_Tratamento ADD CONSTRAINT Prontuario_fk_3 FOREIGN KEY (id_prontuario_Prontuario)
REFERENCES Prontuario(id_prontuario) ON DELETE CASCADE ON UPDATE CASCADE;

-- object: Tratamento_fk | type: CONSTRAINT --
ALTER TABLE many_Prontuario_has_many_Tratamento ADD CONSTRAINT Tratamento_fk FOREIGN KEY (id_tratamento_Tratamento)
REFERENCES Tratamento(id_tratamento) ON DELETE CASCADE ON UPDATE CASCADE;

-- object: many_Condicao_has_many_Prontuario | type: TABLE --

CREATE TABLE many_Condicao_has_many_Prontuario (
    id_condicao_Condicao SMALLINT NOT NULL,
    id_prontuario_Prontuario SMALLINT NOT NULL,
    PRIMARY KEY (id_condicao_Condicao, id_prontuario_Prontuario)
);

-- object: Condicao_fk | type: CONSTRAINT --
ALTER TABLE many_Condicao_has_many_Prontuario ADD CONSTRAINT Condicao_fk FOREIGN KEY (id_condicao_Condicao)
REFERENCES Condicao(id_condicao) ON DELETE CASCADE ON UPDATE CASCADE;

-- object: Prontuario_fk_4 | type: CONSTRAINT --
ALTER TABLE many_Condicao_has_many_Prontuario ADD CONSTRAINT Prontuario_fk_4 FOREIGN KEY (id_prontuario_Prontuario)
REFERENCES Prontuario(id_prontuario) ON DELETE CASCADE ON UPDATE CASCADE;
