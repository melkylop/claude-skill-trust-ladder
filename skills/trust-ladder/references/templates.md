# Modelos prontos

Todos os modelos são `[Adaptação]`: estruturas minhas a partir dos princípios dos vídeos. Troque os `<...>` pelo caso real e apague o que não se aplica.

## Índice
1. Briefing de agente
2. Checklist antes de enviar
3. Skill de verificação + mapa de features
4. Backlog de endurecimento do ambiente
5. Eval de skill
6. Coordenador ("chief of staff") e fila
7. Revisão por amostragem
8. Degraus de confiança e diagnóstico
9. `CLAUDE.md` inicial

---

## 1. Briefing de agente

```
## Intenção
<1 a 3 frases: resultado desejado, para quem, por quê. Use o nome exato dos
conceitos ("regressão de performance", "teste tautológico", "TDD") em vez de
descrições vagas.>

## Contexto e onde olhar
- Arquivos/diretórios/feature: <...>
- Padrão existente para copiar: <arquivo ou feature de referência>
- Dado real (relato, log, trace, screenshot, issue): <cole aqui>
  Não presuma a causa: confirme lendo o código e os dados.

## Restrições
- Fazer: <...>
- Não fazer: <ex.: sem novas dependências; não tocar em <área>; nenhum teste
  que apenas repete a implementação>
- Fora do escopo: <...>

## Como trabalhar
1. Primeiro explore o código e me apresente um plano curto. Não escreva código
   até eu aprovar. (Em tarefa pequena e óbvia, apague este item.)
2. Se pensar mais a fundo, faça depois de carregar o contexto, não antes.
3. Se couber, testes primeiro: escreva os testes, avise que ainda não passam,
   não os rode, faça commit; depois implemente e faça outro commit.

## Como verificar (obrigatório)
1. Ação concreta: <rodar <comando>; subir o app; abrir <tela>; reproduzir o bug
   antes e depois; capturar trace/screenshot>
2. Alvo para iterar: <teste que deve passar, screenshot esperado, saída esperada>.
   Se a primeira tentativa não atingir o alvo, itere até atingir.
3. Resultado observável esperado: <...>
4. O que não puder verificar, diga explicitamente.

## Pronto quando
- [ ] <critério 1>
- [ ] <critério 2>
- [ ] verificação executada, com evidência anexada (saída, screenshot, trace)

## Pare e pergunte quando
- Exigir decisão de produto/arquitetura, mudar contrato público, migrar dados
  ou fazer algo irreversível.
- Você estiver prestes a adivinhar a causa em vez de confirmá-la.

## Entrega
- Mudanças pequenas e atômicas (um assunto por PR/commit); a mensagem explica o porquê.
- Relatório final: o que mudou, como verificou (com evidência), riscos, o que ficou de fora.
```

## 2. Checklist antes de enviar

- [ ] A intenção cabe em 3 frases e tem critério de "pronto" observável?
- [ ] Dá para verificar **sem** um humano copiando erros e prints para o agente? Se não, o humano é o gargalo: crie antes a verificação (§3).
- [ ] Há um dado real no briefing (log, relato, trace) em vez de pedir que o agente suponha?
- [ ] As restrições proíbem o atalho mais provável do agente (o "caminho fácil" errado)?
- [ ] Em tarefa não trivial, o briefing pede plano aprovado antes do código?
- [ ] Há um alvo para iterar (teste, screenshot, saída esperada)?
- [ ] Há condição explícita de parar e perguntar?
- [ ] O pedido pede evidência no relatório, e não só "feito"?

## 3. Skill de verificação + mapa de features

```markdown
---
name: verify-<app>
description: Sobe e exercita <app> de verdade e coleta evidência. Use depois de
  qualquer mudança em <área> ou para reproduzir um relato de bug.
---
# Verificar <app>

## Como subir
<comando(s), variáveis, portas, dados de teste>

## Como controlar
<web/Electron: Playwright ou Chrome DevTools Protocol | iOS: simulador | CLI: stdin/stdout | API: requests>
Scripts: `scripts/<nome>` (partes determinísticas: subir, esperar ficar pronto,
capturar trace/screenshot, limpar). Não reescreva esses scripts a cada uso.

## Mapa de features
Veja `feature-map.md`. Antes de agir sobre um relato, localize a feature ali.

## Evidências a coletar
<screenshot, trace de CPU, heap snapshot, log do console, saída de teste>

## Critério de aprovação
<o que precisa ser verdade para dizer "verificado">

## Manutenção
Ao mudar uma feature, atualize o mapa. Rode a verificação contra um bug
conhecido de vez em quando para provar que ela ainda detecta falhas.
```

`feature-map.md`:

```markdown
## <Feature>
- O que é (visão do usuário): <...>
- Como chegar na UI: <passos / menu / rota>
- Atalhos de teclado: <...>
- Seletores/atributos estáveis (para automação): <...>
- Código principal: <diretório>
- Sub-features / estados: <...>
```

## 4. Backlog de endurecimento do ambiente

Escada de força, da mais forte para a mais mole:
(1) eliminar a categoria do problema · (2) estrutura/convenção única · (3) bloqueio de import e arquitetura · (4) lint / compilador / tipos · (5) CI vermelho · (6) regra, skill, AGENTS.md, bot de review.

| Erro recorrente | Evidência (onde apareceu) | Frequência | Camada atual | Camada alvo | Como implementar | Custo | Prioridade |
|---|---|---|---|---|---|---|---|
| <ex.: arquivo gigante recebe todo código novo> | <PR/chat> | <n> | <mole> | <estrutura: uma feature por diretório> | <...> | <S/M/L> | <1..n> |

Dica `[Vídeo]`: ao revisar PR, cada comentário repetido é cheiro de problema. Pergunte "como viro isso em regra de lint, falha de CI ou elimino o problema de vez?".

## 5. Eval de skill

1. Defina o que a skill deve causar. Peça a um agente coordenador uma **rubrica** pontuável (0 a 10 por critério).
2. Crie 3 a 5 cenários realistas. Para cada um, um diretório isolado com nome neutro (sem "eval", "test" ou o nome da skill), para o sub-agente não saber que está sendo avaliado.
3. Rode sub-agentes **com** e **sem** a skill, cada um no seu diretório.
4. Um **juiz de outro modelo** pontua pela rubrica (evita viés do próprio modelo).
5. Registre notas e falhas. Altere a skill e repita (hill climbing) até a meta, por exemplo média 10/10, com limite de iterações.
6. Se possível, repita em mais de um modelo e compare.

Observação `[Vídeo]`: manter skills dá trabalho e exige observar as ações do agente (tool calls, thinking), não só o resultado final.

## 6. Coordenador ("chief of staff") e fila

Prompt-base do coordenador:

```
Você coordena agentes. Não implementa nada você mesmo.
Entrada: <fonte: canal, issues, lista>.
1. Agrupe itens relacionados antes de delegar (evita trabalho duplicado e revela a causa comum).
2. Para cada grupo, crie um sub-agente com um briefing completo (modelo §1).
3. Acompanhe, junte os relatórios, e diga o que ficou sem verificação.
4. Nunca faça merge. Entregue a lista de PRs com evidência.
```

Coordenação mínima `[Boris]`: se os agentes rodam em paralelo (abas, checkouts ou git worktrees diferentes) e precisam trocar informação, peça que escrevam num arquivo markdown compartilhado (`coordenacao.md`: quem faz o quê, o que já terminou, o que bloqueia). Na maioria dos casos nem isso é preciso.

Fila (buffer) para padrões `[Vídeo]`: em vez de corrigir cada achado, o agente **acrescenta** ao documento `achados.md` (data, local, descrição). A cada poucos dias, leia e procure o que se repete; cada padrão vira correção de ambiente (§4).

## 7. Revisão por amostragem

- Sorteie ou escolha alguns PRs já integrados (ou olhe o histórico de commits do dia).
- Procure: atalhos repetidos, mesma gambiarra em vários lugares, testes sem valor, regressões.
- Se for caso isolado, tudo bem. Se **vários agentes** erraram igual, **corrija o ambiente** (§4), não o PR.
- Anote o que descobriu e o que virou regra.
- Para mudanças irreversíveis (dados, pagamentos, saúde, direito), não use amostragem: exija verificação específica ou revisão humana antes do merge.

## 8. Degraus de confiança e diagnóstico

`[Adaptação]` Lauren desenha uma curva de confiança, sem numerar degraus. Esta divisão é minha.

1. **Dentro do loop:** 1 a 5 agentes; você lê cada saída e age como proxy entre o agente e o app.
2. **Verificação local:** o agente roda o app e prova o próprio trabalho; você deixa de copiar erros e prints.
3. **Ambiente restritivo:** erros recorrentes viram regras duras (lint, tipos, estrutura, CI).
4. **Gatilhos e nuvem:** relatos (Slack, Linear, e-mail) disparam agentes; coordenador agrupa; você revisa PRs.
5. **Auto-merge com revisão posterior:** só com verificação forte e ambiente restritivo; revisão por amostragem do que já entrou.

Perguntas de diagnóstico:
- Você lê toda saída do agente antes de aceitar? (degrau 1)
- O agente consegue rodar e ver o resultado sozinho? (sim = pelo menos 2)
- O mesmo erro volta mesmo depois de você corrigir? (sim = falta degrau 3)
- Relatos de bug chegam ao agente sem você copiar? (sim = degrau 4)
- Um merge ruim à noite seria barato de reverter? (não = fique antes do 5 neste projeto)

## 9. `CLAUDE.md` inicial

`[Boris]` O arquivo pode ficar na raiz do repositório, em subpastas (carregado sob demanda) e na pasta pessoal. O modelo abaixo é `[Adaptação]`. Mantenha curto e só com o que o agente não descobre sozinho lendo o código.

```markdown
# <Projeto>

## Comandos
- Instalar: `<...>`
- Rodar em desenvolvimento: `<...>`
- Testes (todos / um arquivo): `<...>` / `<...>`
- Lint e tipos: `<...>`

## Convenções
- <ex.: uma feature por diretório em src/features/<nome>>
- <ex.: erros de domínio usam a classe X, nunca throw genérico>

## Armadilhas conhecidas
- <ex.: o teste Y é lento; rode só com --grep>
- <ex.: nunca editar arquivos gerados em /dist>

## Ferramentas
- `<cli>`: <para que serve>. Detalhes: rode `<cli> --help`.
  (Se for ferramenta nova, peça ao agente para rodar --help e registrar aqui o que aprendeu.)

## Como verificar uma mudança
- <passos curtos; link para a skill de verificação, se existir>
```
