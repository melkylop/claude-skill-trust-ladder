---
name: trust-ladder
description: Método para delegar trabalho de código a agentes de IA com confiança (a "escada de confiança" de Lauren Tan, Cursor/SpaceX AI, mais dicas práticas de Boris Cherny, criador do Claude Code). Use quando o usuário quiser escrever ou melhorar um prompt/briefing para um agente, planejar antes de codar, preparar o contexto do projeto (CLAUDE.md, comandos, ferramentas), criar uma skill de verificação, transformar erros repetidos do agente em lint/CI/regras, minerar transcrições de chats para virar skills, avaliar uma skill, ou escalar para vários agentes e auto-merge de PRs. Gatilhos incluem "prompt para agente", "briefing", "verificação", "escada de confiança", "CLAUDE.md", "agentes em paralelo", "revisar PR de agente", "agent prompt", "verification skill", "trust ladder". Invoque com /trust-ladder seguido da tarefa.
license: MIT
---

# Escada de confiança (trust ladder)

Método para delegar a agentes só o que dá para verificar, e subir de nível conforme a confiança é conquistada. Baseado em quatro fontes: três vídeos de Lauren Tan (talk em duas partes e uma entrevista de 65 min) e uma talk de 18 min de Boris Cherny (2025). Fontes e tempos em [references/fontes.md](references/fontes.md); modelos prontos em [references/templates.md](references/templates.md).

Pedido do usuário (se houver): $ARGUMENTS

**Convenção:** `[Vídeo]` = ideia dita por Lauren Tan. `[Boris]` = ideia dita por Boris Cherny. `[Adaptação]` = sugestão minha, não dita por eles. Ao responder, mantenha essa distinção e nunca atribua a ninguém números ou frases que não estejam nas fontes. A talk de Boris é de 2025: recursos e atalhos citados podem ter mudado, confira na documentação atual antes de afirmar.

## Escolha o modo

Leia o pedido e escolha UM modo. Se for ambíguo, faça uma única pergunta curta.

| Modo | Quando | Saída |
|---|---|---|
| `brief` (padrão) | "escreva um prompt/briefing para o agente fazer X" | briefing pronto para colar, ou executado aqui |
| `contexto` | preparar o projeto para agentes (CLAUDE.md, comandos, ferramentas) | arquivos de contexto prontos |
| `verificar` | agente "chuta" porque não consegue rodar/ver o resultado | skill de verificação + mapa de features |
| `ambiente` | o agente repete o mesmo erro | backlog de restrições duras (lint, tipos, CI, estrutura) |
| `minerar` | há histórico de chats com correções repetidas | lista priorizada de skills/regras a criar |
| `avaliar` | quer saber se uma skill funciona | plano e rubrica de eval |
| `escalar` | quer vários agentes, gatilhos, auto-merge | diagnóstico do degrau + plano do próximo passo |

## Princípios

1. **Confiança sobe por degraus; não se pula.** `[Vídeo]` Sem confiar em 1 agente, rodar 100 só gasta token. Ver degraus em templates.md §8.
2. **Verificação primeiro.** `[Vídeo]` "Sem skill de verificação, você é o verificador, o gargalo." Dar ao agente mãos e olhos: rodar o app de verdade, traces, snapshots, simulador. Isso garante código *correto*, não necessariamente *bom*.
3. **Loop = verificação, e todo loop precisa de um alvo.** `[Vídeo]` Se o agente não vê o resultado do próprio trabalho, não itera. Com rubrica e nota dá para fazer *hill climbing* (repetir até a nota-alvo), com juiz de outro modelo. `[Boris]` Alvo pode ser teste unitário ou de integração, screenshot no simulador iOS ou no Puppeteer; a primeira tentativa sai "ok", a segunda ou terceira sai boa.
4. **Ambiente vence prompt.** `[Vídeo]` Transforme erro recorrente em restrição *dura* (estrutura, bloqueio de import, lint, tipos, CI vermelho). Regras, skills e bot de review são camadas *moles*: o agente esquece. "O caminho mais curto tem que ser o caminho certo." Se você comenta a mesma coisa em code review duas vezes, vire regra.
5. **Determinístico para a máquina, julgamento para o agente.** `[Vídeo]` Extraia o mecânico para CLI/script/codemod e deixe no texto da skill só o que exige julgamento. Skill menor, comportamento mais consistente.
6. **Skills nascem de falhas observadas.** `[Vídeo]` Leia tool calls, thinking e transcrições; cada falha vira skill ou lint. Com modelos novos, menos detalhe de implementação e mais passos de processo.
7. **Contexto, não controle.** `[Vídeo]` Pergunte "por que o agente precisa de mim aqui?" e ensine-o a buscar o dado real, sem palpite. Você é o proxy humano em cada ponto que não automatizou.
8. **Intenção clara é o gargalo.** `[Vídeo]` Linguagem precisa e palavras que o agente "agarra" (TDD, "teste tautológico"). Perguntas de entrevista (*grilling*) ajudam a extrair a intenção.
9. **A responsabilidade continua humana.** `[Vídeo]` Revisão por amostragem; ao achar o mesmo problema em vários PRs, conserte o ambiente, não o agente individual.
10. **Andaime simples; reavalie a cada modelo novo.** `[Boris]` "O modelo mais geral sempre vence": Claude Code é propositalmente mínimo e sem opinião, porque ainda não se sabe qual é a melhor interface. `[Vídeo]` Lauren prevê skills cada vez menores. Antes de adicionar regra ou etapa, pergunte se o próximo modelo já a tornaria desnecessária; mas restrições *duras* do projeto (princípio 4) continuam valendo.

## Modo `brief`

1. **Degrau.** Estime onde o usuário está (templates.md §8). Quem observa cada saída precisa de briefing curto e verificação local; quem já delega precisa de restrições e critérios mais rígidos.
2. **Intenção.** Se faltar resultado desejado ou critério de pronto, entreviste: uma pergunta por vez, cada uma com sua resposta recomendada, no máximo 5. Pare quando intenção e "pronto quando" estiverem claros. `[Adaptação]`
3. **Explore antes de escrever** (se houver acesso ao repo): onde fica a feature, comandos de build/test/lint, padrões a copiar, restrições existentes. Não adivinhe.
4. **Plano antes do código** `[Boris]` em tarefa não trivial: o briefing manda o agente explorar, propor um plano e esperar aprovação antes de escrever código. No Claude Code isso é o plan mode (Shift+Tab, conforme a talk de 2025). Pensar mais (extended thinking) rende depois que o contexto já foi carregado com ferramentas; pensar antes, sem contexto, tende a gastar token à toa.
5. **Testes primeiro, quando couber** `[Boris]`: peça ao agente para escrever os testes, avisar que ainda não passam (e não rodá-los), fazer commit, só então implementar e fazer outro commit.
6. **Monte o briefing** com o modelo de templates.md §1 e passe o checklist de §2.
7. **Entregue** em bloco copiável. Se o usuário pedir para executar, execute seguindo o próprio briefing e termine com o relatório de evidência.

## Modo `contexto`

1. **Arquivo de contexto** `[Boris]`: `CLAUDE.md` na raiz do repositório, em subpastas (carregado sob demanda) e na pasta pessoal (vale para todos os projetos). Conteúdo: comandos de build/test/lint, convenções, armadilhas conhecidas. Modelo em templates.md §9.
2. **Ensine as ferramentas** `[Boris]`: para uma CLI nova, peça ao agente para rodar `--help` e registrar o que aprendeu no `CLAUDE.md`; sem ponte nem extensão. Use MCP quando houver grupos de ferramentas ou recursos como streaming.
3. **Fluxos repetidos viram comandos** `[Boris]`: arquivos markdown em `.claude/commands` aparecem no menu de barra. Quando o fluxo é um processo mais longo, prefira uma skill.
4. **Entrada fácil** `[Boris]`: perguntas sobre o código (onboarding) e "o que eu entreguei esta semana?" a partir dos commits. Boris diz que isso reduziu o onboarding de 2 a 3 semanas para cerca de 2 dias na Anthropic.
5. `[Adaptação]` Mantenha curto. Cada linha do `CLAUDE.md` compete por atenção, e o que já é imposto por lint ou CI (princípio 4) não precisa estar lá.

## Modo `verificar`

1. Descubra como o app chega ao usuário (web, Electron/CDP, iOS/simulador, CLI, API) e comece **local e observável**, antes de nuvem.
2. Entregue uma skill de verificação (templates.md §3) com: como subir o app, como controlá-lo, **mapa de features** (feature → como chegar → atalhos → seletores), evidências a coletar e critério de aprovação.
3. Mova o mecânico para script/CLI dentro da skill, para todo agente reutilizar em vez de reinventar.
4. Valide a verificação: rode com um bug conhecido e confirme que ela o detecta. `[Adaptação]` De Lauren: a skill de verificação também foi iterada com loop e rubrica.
5. Inclua como mantê-la atualizada.

## Modo `ambiente`

1. Reúna os erros repetidos (relatados pelo usuário, histórico, PRs).
2. Classifique cada um na escada de força: eliminar a categoria > estrutura/convenção única > bloqueio de import > lint/compilador/tipos > CI vermelho > regra/skill/bot (mole).
3. Entregue o backlog (templates.md §4) e implemente o de maior alavanca. Não tudo de uma vez.
4. Avise o custo: refatorar para um ambiente restritivo gasta muito token no início. Projeto novo sem guard rails é o maior risco; projeto antigo de empresa grande costuma já ter guard rails. `[Vídeo]`

## Modo `minerar`

1. Fonte: histórico de sessões (no Claude Code ficam em `~/.claude/projects/`). `[Vídeo]` Lauren descreve transcrições passadas como "tesouro de contexto".
2. Procure momentos em que o usuário corrigiu, repetiu instrução ou interveio. Agrupe por padrão.
3. Para cada padrão, proponha o destino: skill de processo, regra de lint, ou documento. Liste com um trecho de evidência. Não crie nada antes de o usuário escolher.

## Modo `avaliar`

Eval é "teste unitário de um agente". `[Vídeo]` Use templates.md §5: rubrica, sub-agentes em diretórios isolados com nomes que não revelam que é avaliação, juiz de outro modelo, nota, loop até a meta e, se possível, vários modelos. Se a skill `skill-creator` estiver disponível, ela já traz ferramentas de eval.

## Modo `escalar`

1. Diagnostique o degrau (templates.md §8) e diga o **próximo** degrau, não o último.
2. Dois loops `[Vídeo]`: **interno** (agentes trabalhando na intenção) e **externo** (Slack, Linear, X, e-mail trazendo contexto novo). Conecte-os para o agente buscar o próprio contexto.
3. **Coordenador** ("chief of staff") `[Vídeo]`: delega e supervisiona, não executa; vê o conjunto e evita trabalho duplicado em relatos parecidos (templates.md §6).
4. **Fila antes de consertar tudo** `[Vídeo]`: às vezes acumular achados num documento e revisar a cada poucos dias revela padrões que o modo execução perde.
5. **PRs pequenos e atômicos** `[Vídeo]`: histórico git vira contexto e facilita reverter.
6. **Auto-merge só com** verificação forte + ambiente restritivo. Mudanças irreversíveis ("portas de mão única": perda de dados etc.) exigem verificação melhor ou revisão humana. Lauren admite não ter resposta pronta para domínios difíceis de verificar. `[Vídeo]`
7. Revise por **amostragem** (templates.md §7).
8. Faça conta de **ROI**: Lauren trabalha num laboratório com tokens ilimitados e diz que não vale copiar o método igual. `[Vídeo]`
9. **Paralelismo simples primeiro** `[Boris]`: vários terminais, checkouts diferentes ou *git worktrees* do mesmo repositório; GitHub Actions para disparar vários de uma vez. Na maioria dos casos não precisa coordenar; se precisar, peça que escrevam num arquivo markdown compartilhado. Só então suba para coordenador (item 3).
10. **Automação por linha de comando** `[Boris]`: `claude -p` roda sem interface e funciona como utilitário Unix (receber logs por pipe, devolver texto que se filtra com `jq`). Serve para triagem e para o loop externo.

## Conduta de Claude ao usar esta skill

- Nunca diga "verificado" sem ter rodado a verificação. Relate o que rodou, o resultado, e o que ficou sem verificar.
- Não recomende auto-merge, autopilot nem dezenas de agentes antes de os pré-requisitos existirem.
- Não imponha as preferências de Lauren como regra universal (ex.: banir comentários, banir `useEffect`). São escolhas de um projeto. Ofereça-as como exemplo de restrição dura.
- Dicas de produto vindas da talk de Boris (atalhos, `#` para memória, plan mode, `claude -p`) são de 2025. Antes de instruir o usuário a apertar uma tecla ou rodar um comando, confirme que ainda existe na versão dele.
- Seja honesto sobre limites: o método não tem atalho, custa token, e nem todo domínio é verificável. O número de PRs não mede valor de produto.
