# Automatização de Matrículas e Mensagens
Este projeto foi criado para automatizar um processo de matrículas e envio de mensagens, que inicialmente era feito manualmente, o que o tornava lento e propenso a erros. A solução inicial foi desenvolvida em Python e, posteriormente, migrada para Flutter, utilizando Dart para oferecer uma interface mais agradável e funcional.

## Contexto do Problema
O processo manual envolvia as seguintes etapas:

 - Trocar constantemente de aba no navegador para pegar dados (nome, e-mail, CPF, etc.) de uma conversa no ChatGuru.
 - Criar e editar usuários na plataforma EAD.
 - Atualizar as informações do usuário, como CPF e senha.
 - Liberar a matrícula e enviar 4 mensagens com dados específicos, como e-mail e senha.
 - Repetir o processo para cada novo usuário.
Este fluxo não era eficiente e consumia muito tempo, principalmente pelo número de abas envolvidas e a repetição manual das ações.

## Solução Desenvolvida
A solução criada em Flutter permite:

 - Inserir todos os dados do cliente em uma única tela.
 - Selecionar se a mensagem de confirmação deve ser enviada ou não (caso apenas um link de pagamento seja necessário, a mensagem não precisa ser enviada).
 - Enviar automaticamente os dados para a API da plataforma EAD, cadastrando ou atualizando o usuário.
 - Se o usuário já existir na plataforma, o sistema apenas atualiza os dados fornecidos.
 - Conectar-se à API do ChatGuru para enviar as mensagens automáticas com o e-mail e senha cadastrados.
 - Executar um diálogo automatizado no ChatGuru (série de mensagens do chatbot) após o cadastro.
 - Preencher automaticamente os campos adicionais no ChatGuru, evitando a necessidade de edição manual.

## Tecnologias Utilizadas
 - Python: Solução inicial para automatização do processo (focada na lógica e integração de APIs).
 - Flutter/Dart: Migração para uma solução com interface gráfica e melhorias na usabilidade.
 - APIs: Integração com APIs da plataforma EAD e ChatGuru.
 - Future.wait: Otimização das requisições para envio paralelo dos dados, melhorando significativamente a performance.


## Aprendizados
Durante o desenvolvimento deste projeto, foram adquiridos conhecimentos em:

 - Tratamento de APIs: Manipulação de diferentes tipos de dados, como strings e inteiros, dependendo da requisição.
 - Passagem de Dados entre APIs: Compreensão da intermediação entre diferentes APIs, passando os dados de uma plataforma para outra.
 - Otimização de Requisições: Uso do método Future.wait em Flutter para realizar múltiplas requisições simultâneas, aumentando a eficiência do sistema.
 - Desenvolvimento em Flutter: A criação de uma interface funcional e responsiva, além de trabalhar com as especificidades do Dart.

## Como Utilizar
 - Clone este repositório.
 - Configure as chaves de API para a plataforma EAD e ChatGuru.
 - Insira os dados dos clientes na interface e selecione as ações desejadas.
 - O sistema cuidará do restante, desde o cadastro na plataforma EAD até o envio das mensagens no ChatGuru.
