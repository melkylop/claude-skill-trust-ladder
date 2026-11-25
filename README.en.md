# claude-skill-trust-ladder

[Português](README.md) | English

A skill for Claude Code (VS Code and terminal) and the Claude app: delegate coding work to AI agents with confidence. It covers agent briefs, planning before code, `CLAUDE.md`, verification skills, hard constraints (lint, types, CI), skill evals, and scaling to many agents.

Invoke it with `/trust-ladder` followed by your task. The files live in [`skills/trust-ladder`](skills/trust-ladder/SKILL.md), inside a `skills/` folder that can hold more skills later.

**Language note:** the skill's instructions and templates are written in Portuguese (Brazil). English translations are welcome (see [`CONTRIBUTING.md`](CONTRIBUTING.md), which is also in Portuguese).

## What it does

Seven modes, picked from your request: `brief` (write the brief for the agent), `contexto` (prepare the project: `CLAUDE.md`, commands, tools), `verificar` (build a verification skill), `ambiente` (turn repeated agent mistakes into hard rules), `minerar` (find patterns in your chat history), `avaliar` (test a skill), and `escalar` (many agents, auto-merge with caution). Ready-made templates are in [`references/templates.md`](skills/trust-ladder/references/templates.md), and a paste-anywhere version for any chat is in [`references/prompt-colavel.md`](skills/trust-ladder/references/prompt-colavel.md).

The core idea: only delegate what can be verified, and move up one step at a time as trust is earned.

## Origin and notices

- **Basis:** automatic transcripts (YouTube captions, SozAI and Whisper) of videos by Lauren Tan (Cursor/SpaceX AI) and a talk by Boris Cherny (Anthropic), listed in [`fontes.md`](skills/trust-ladder/references/fontes.md) (Portuguese), not the videos themselves. Full transcripts are not included, since they are third-party content.
- **It may contain errors.** Automatic captions swap names and terms, and the interpretation may be wrong. Check the original video before quoting anyone.
- **No affiliation.** This project is not related to, endorsed by, or reviewed by Lauren Tan, Boris Cherny, Cursor, SpaceX AI or Anthropic. Names and trademarks belong to their owners.
- **Tags in the text:** `[Vídeo]` means said by Lauren Tan, `[Boris]` by Boris Cherny, and `[Adaptação]` is a suggestion from this repository, not said by them. Not every idea has to come from a video: standalone improvements are welcome.
- **Dates:** Boris Cherny's talk is from 2025. Features and shortcuts mentioned there may have changed.

## Install on a computer

Windows (PowerShell):

```powershell
git clone https://github.com/melkylop/claude-skill-trust-ladder.git
cd claude-skill-trust-ladder
.\scripts\install.ps1
```

If Windows blocks the script, use `powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1`.

macOS or Linux:

```sh
git clone https://github.com/melkylop/claude-skill-trust-ladder.git
cd claude-skill-trust-ladder
sh scripts/install.sh
```

The scripts copy each folder in `skills/` to `~/.claude/skills/`, the personal folder Claude Code reads in the app and in VS Code. If a folder with the same name as one of this repository's skills already exists, it is **replaced**; others are left alone. Then open a new session so the skill shows up.

To install somewhere else, pass `-Destino PATH` (PowerShell) or set `DESTINO=PATH` (sh).

## Update

```sh
git pull
```

then run the install script again.

## Use in a single project

Copy `skills/trust-ladder` to `.claude/skills/trust-ladder` inside the project and commit it. Anyone who clones the project gets the skill, in that project only.

## Upload to your account (claude.ai or the app)

```sh
python scripts/make-zip.py trust-ladder
```

This creates `trust-ladder.zip` with the skill folder at the root. Upload it on the Skills screen in settings (the exact menu name varies). Skills uploaded to your account do **not** follow changes in this repository: rebuild the zip and upload again after each update.

## Add another skill

1. Create `skills/NAME/SKILL.md` with `name` and `description` at the top of the file.
2. In `description`, avoid the `<` and `>` characters and the sequence colon-plus-space (they break header parsing).
3. Run the install script.

## Contributing

Standalone improvements are welcome and do not need to come from a video. See [`CONTRIBUTING.md`](CONTRIBUTING.md).

## License

[MIT](LICENSE). It covers the text in this repository. It does not cover the videos, talks and other works cited, which belong to their authors.
