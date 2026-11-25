# Fontes e onde cada ideia aparece

Esta página registra de onde saíram as ideias marcadas com `[Vídeo]` e `[Boris]`. Melhorias avulsas (`[Adaptação]`) não precisam de entrada aqui.

Quatro fontes: três com Lauren Tan (Cursor / SpaceX AI) e uma talk de Boris Cherny (Anthropic, criador do Claude Code). A tabela do Boris está no fim deste arquivo.

Fontes de Lauren Tan:

- **Talk, Parte 1:** https://www.youtube.com/watch?v=PaPpyQocMww (~55 min). A Parte 2 (https://www.youtube.com/watch?v=wZPBQYuAC_s) é a mesma talk com outro corte; os tempos abaixo valem para a Parte 1 e variam poucos segundos na Parte 2.
- **Entrevista de 65 min:** https://sozai.app/transcript/lauren-tan-30-ai-agents-ship-prs/ (vídeo diferente; quem entrevista não é identificado de forma confiável nas legendas).
- As transcrições completas não fazem parte da skill nem do repositório (são conteúdo de terceiros): use os links acima para ler ou transcrever de novo.

**Ressalvas:** as transcrições são legendas automáticas. Nomes saem trocados ("PAC" = Pstack; "Grockbot/Rockbot/Graphbot" = o mesmo app; "Carpathy" = Karpathy). Antes de citar um número ou termo técnico, confira no texto. Os números de PRs diferem entre as fontes: na talk, ~1.000 PRs no mês anterior e ~800 até o dia 12; na entrevista, o assunto é uma talk posterior sobre 2.500 PRs.

## Talk (Parte 1)

| Ideia | Tempo |
|---|---|
| Curva de confiança; analogia com gestão e micromanagement; agentes fazendo auto-merge | 0:46 a 5:19 |
| Verificação como habilidade principal: rodar o código, traces, heap snapshots, simulador | 5:33 a 6:26 |
| "Sem skill de verificação, você é o verificador, o gargalo" | 8:13 a 8:52 |
| Mapa de features junto da skill de verificação; mapear relatos vagos ou só um screenshot | 9:50 a 13:08 |
| Pstack nasceu incrementalmente de falhas observadas; skill = markdown; "puxar o agente para outro espaço latente" | 14:03 a 16:40 |
| Evals como teste unitário de agente; playbook de eval; diretórios com nomes que escondem a avaliação; vários modelos | 17:28 a 19:50 |
| Manter skills exige gosto e observação; ler tool calls e thinking | 19:58 a 21:00 |
| Hill climbing: nota, juiz de outro modelo, `/loop` até 10/10 | 21:05 a 22:10 |
| Comece local; depois agentes na nuvem; agente que reproduz relatos de bug; não pule para milhares de agentes | 23:46 a 26:53 |
| Recapitulando: verificação, nuvem, depois auto-merge; "sem atalho" | 26:53 a 29:12 |
| Reescrever/greenfield; "antes do AI slop, tínhamos human sloth"; guard rails de big tech | 29:22 a 32:00 |
| App vibe-coded sem restrições vira bagunça; restrições fortes desde o início | 32:43 a 35:23 |
| Tamanho de PR: sem teto; prefere PRs atômicos; histórico git como contexto | 35:31 a 37:43 |
| Arquitetura "Dune": useEffect banido, comentários de código banidos, bloqueio de import entre diretórios, CI | 38:01 a 42:09 |
| Camadas duras (estrutura, CI, lint, compilador) vs moles (rules, skills, bug bot); "o caminho mais curto é o melhor"; Rust como exemplo de compilador estrito | 42:09 a 46:37 |
| Se você faz a restrição valer por code review, é cheiro de problema: vire lint ou CI | 46:47 a 47:22 |
| Custo em tokens e ROI; não vale copiar igual; modelos fracos funcionam bem em ambiente restritivo | 48:00 a 52:46 |
| PMs e designers contribuindo; a arquitetura restritiva permite | 52:46 a 55:24 |

## Entrevista (65 min)

| Ideia | Tempo |
|---|---|
| Origem: burnout, projeto paralelo, micromanagement de um agente, primeiras skills | 1:04 a 4:02 |
| Expertise de domínio importa mais; o gargalo é expressar a intenção | 6:04 a 7:47 |
| Linguagem: palavras que o agente "agarra" (TDD, tautológico); grilling | 7:47 a 9:49 |
| Metáfora da cozinha Michelin no lugar de "software factory"; responsabilidade humana | 10:44 a 14:38 |
| Verificação como a skill mais importante; loops; hill climbing; auto research de Karpathy | 15:55 a 18:25 |
| CLI com o determinístico dentro da skill; gradiente determinismo vs julgamento; codemods | 18:58 a 24:18 |
| "O novo trabalho do engenheiro é cuidar do ambiente"; afiar as facas | 25:40 a 28:10 |
| Type narrowing, restrições, framework Dune, diretório por feature | 28:10 a 32:09 |
| Como chega a milhares de PRs: loops interno e externo, "por que o agente precisa de mim?", contexto em vez de controle | 33:15 a 38:13 |
| Projetos/coordenadores na nuvem, chief of staff, agrupar relatos parecidos | 38:13 a 44:52 |
| Jardinagem do código; fila/buffer de achados; coordenador "vê a floresta" | 45:17 a 48:30 |
| Revisão por amostragem; corrigir o ambiente; "fábrica escura"; autopilot com agentes verificadores e fuzzing; revisar depois do merge | 48:59 a 54:11 |
| Portas de mão única vs mão dupla; verificabilidade do domínio; linguagens com provas | 55:09 a 58:57 |
| Combinar skills; minerar transcrições; skill "recall"; skills ficam menores e mais focadas em fluxo | 59:26 a 64:30 |

## Talk de Boris Cherny (18 min, 2025)

Fonte: https://ai.engineer/talks/claude-code-the-evolution-of-agentic-coding (AI Engineer World's Fair 2025). Transcrição consultada: espelho em https://lawwu.github.io/transcripts/Lue8K2jqfKk.html, feito por Whisper (escreve "quad code" onde se lê Claude Code). Confira no vídeo original antes de citar.

**Data:** a talk cita o plano Pro/Max "desde ontem" e o plan mode "lançado hoje". Atalhos, comandos e nomes de recursos podem ter mudado desde então.

| Ideia | Tempo |
|---|---|
| Modelo em ritmo exponencial; Claude Code propositalmente simples e sem opinião, porque não se sabe a melhor interface | 0:56 a 1:36 e 7:34 a 8:28 |
| Verificação evoluiu de depuração manual para fuzzing, testes de vulnerabilidade e chaos testing | 7:12 a 7:34 |
| "O modelo mais geral sempre vence" (bitter lesson) | 8:33 a 9:00 |
| Terminal, IDE, GitHub e SDK como formas de usar o mesmo produto | 9:00 a 10:54 |
| `claude -p` como utilitário Unix: logs por pipe, resultado filtrado com `jq` | 10:54 a 11:50 |
| Perguntas sobre o código; onboarding de 2 a 3 semanas para cerca de 2 dias; "o que eu entreguei esta semana" pelos commits | 12:08 a 12:51 |
| Ensinar ferramentas: rodar `--help` e registrar no CLAUDE.md; MCP para grupos de ferramentas | 12:51 a 13:40 |
| Plano primeiro; extended thinking depois de carregar contexto | 13:53 a 14:25 |
| TDD com instruções explícitas; alvo para iterar (testes, screenshot, até câmera em impressora 3D) | 14:25 a 15:27 |
| Plan mode (Shift+Tab) | 15:27 a 15:51 |
| CLAUDE.md na raiz, subpastas e pasta pessoal; comandos em `.claude/commands`; `#` para memorizar | 15:51 a 16:52 |
| Vários Claudes em paralelo: abas, checkouts, worktrees, GitHub Actions; coordenar por arquivo markdown | 17:28 a 17:58 |
