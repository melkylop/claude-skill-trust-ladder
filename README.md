# claude-skill-trust-ladder

Skill para o Claude Code (VS Code e terminal) e para o app do Claude: delegar trabalho de código a agentes de IA com confiança. Cobre briefing de agente, plano antes do código, `CLAUDE.md`, skill de verificação, restrições duras (lint, tipos, CI), eval de skills e escala para vários agentes.

Chame com `/trust-ladder` seguido da tarefa. Os arquivos ficam em [`skills/trust-ladder`](skills/trust-ladder/SKILL.md), dentro de uma pasta `skills/` que aceita outras skills no futuro.

## O que a skill faz

Seis modos, escolhidos pelo seu pedido: `brief` (escrever o briefing para o agente), `contexto` (preparar o projeto), `verificar`, `ambiente` (transformar erro repetido em regra dura), `minerar` (achar padrões no histórico de chats), `avaliar` (testar uma skill) e `escalar` (vários agentes, auto-merge com cautela). Modelos prontos ficam em [`references/templates.md`](skills/trust-ladder/references/templates.md), e há uma versão para colar em qualquer chat em [`references/prompt-colavel.md`](skills/trust-ladder/references/prompt-colavel.md).

## Origem e avisos

- **Base:** transcrições **automáticas** (legendas do YouTube, SozAI e Whisper) de vídeos de Lauren Tan (Cursor/SpaceX AI) e de uma talk de Boris Cherny (Anthropic), listadas em [`fontes.md`](skills/trust-ladder/references/fontes.md), e não os vídeos em si. As transcrições completas ficam fora do repositório, por serem conteúdo de terceiros.
- **Pode haver erros.** Legendas automáticas trocam nomes e termos, e a interpretação pode estar errada. Confira no vídeo original antes de citar alguém.
- **Sem vínculo.** Este projeto não tem relação, apoio nem revisão de Lauren Tan, Boris Cherny, Cursor, SpaceX AI ou Anthropic. Nomes e marcas pertencem aos seus donos.
- **Marcações no texto:** `[Vídeo]` é dito por Lauren Tan, `[Boris]` por Boris Cherny e `[Adaptação]` é sugestão deste repositório, não dita por eles. Nem toda ideia precisa vir de um vídeo: melhorias avulsas são bem-vindas.
- **Datas:** a talk de Boris Cherny é de 2025. Recursos e atalhos citados podem ter mudado.

## Instalar em um computador

Windows (PowerShell):

```powershell
git clone https://github.com/melkylop/claude-skill-trust-ladder.git
cd claude-skill-trust-ladder
.\scripts\install.ps1
```

Se o Windows bloquear o script, use `powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1`.

macOS ou Linux:

```sh
git clone https://github.com/melkylop/claude-skill-trust-ladder.git
cd claude-skill-trust-ladder
sh scripts/install.sh
```

Os scripts copiam cada pasta de `skills/` para `~/.claude/skills/`, a pasta pessoal que o Claude Code lê no app e no VS Code. Se já existir uma pasta com o mesmo nome de uma skill deste repositório, ela é **substituída**; as demais não são tocadas. Depois abra uma sessão nova para a skill aparecer.

Para instalar em outra pasta, passe `-Destino CAMINHO` (PowerShell) ou defina `DESTINO=CAMINHO` (sh).

## Atualizar

```sh
git pull
```

e rode o script de instalação de novo.

## Usar só em um projeto

Copie `skills/trust-ladder` para `.claude/skills/trust-ladder` dentro do projeto e faça commit. Quem clonar o projeto passa a ter a skill, e só nele.

## Enviar para a conta (claude.ai ou app)

```sh
python scripts/make-zip.py trust-ladder
```

Gera `trust-ladder.zip` com a pasta da skill na raiz. Envie o arquivo na tela de Skills das configurações (o nome exato do menu varia). Skills enviadas para a conta **não** acompanham mudanças deste repositório: gere o zip e envie de novo a cada atualização.

## Adicionar outra skill

1. Crie `skills/NOME/SKILL.md` com `name` e `description` no início do arquivo.
2. Na `description`, evite os sinais `<` e `>` e a sequência dois-pontos seguida de espaço (quebram a leitura do cabeçalho).
3. Rode o script de instalação.

## Contribuir

Melhorias avulsas são bem-vindas e não precisam vir de vídeo. Veja [`CONTRIBUTING.md`](CONTRIBUTING.md).

## Licença

[MIT](LICENSE). Vale para o texto deste repositório. Não cobre os vídeos, talks e demais obras citadas, que pertencem aos seus autores.
