# 🦷 Clínica Odontológica – Banco de Dados  
Repositório contendo o script SQL (dump) da base de dados desenvolvida para o projeto acadêmico da disciplina **Banco de Dados I (BD1)**, da FAETERJ Petrópolis.

Este banco de dados foi projetado para atender às necessidades de uma clínica odontológica, permitindo o gerenciamento de **pacientes, dentistas, horários, procedimentos e consultas**, garantindo integridade, consistência e organização dos dados.

---

## 📌 Estrutura do Banco

O banco contém as seguintes tabelas:

- **pacientes**  
  Armazena dados pessoais, contato e histórico básico dos pacientes.

- **dentistas**  
  Guarda informações dos profissionais, incluindo CPF, CRO e especialidade.

- **procedimentos_odontologicos**  
  Catálogo de procedimentos oferecidos pela clínica.

- **consultas**  
  Registra consultas agendadas ou realizadas, vinculando paciente, dentista, horário e status.

- **consultas_procedimentos**  
  Tabela associativa que representa o relacionamento *N:N* entre consultas e procedimentos.

- **horarios_atendimento**  
  Define os horários disponíveis de cada dentista durante os dias da semana.

---

## 🛠️ Tecnologias Utilizadas

- **MySQL 8+**
- **Workbench (opcional)**
- **SGBD compatível com SQL ANSI**

---
