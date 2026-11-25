"""Gera um .zip de uma skill, pronto para enviar ao claude.ai.

Uso: python scripts/make-zip.py NOME [SAIDA.zip]

O zip fica com a pasta da skill na raiz (NOME/SKILL.md, NOME/references/...),
com barras normais nos caminhos, que e o formato esperado no envio.
"""
import os
import sys
import zipfile


def main() -> int:
    if len(sys.argv) < 2:
        print(__doc__)
        return 2
    nome = sys.argv[1]
    raiz = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    pasta = os.path.join(raiz, "skills", nome)
    if not os.path.isfile(os.path.join(pasta, "SKILL.md")):
        print(f"Skill '{nome}' nao encontrada em {pasta} (falta SKILL.md).")
        return 1
    saida = sys.argv[2] if len(sys.argv) > 2 else f"{nome}.zip"

    with zipfile.ZipFile(saida, "w", zipfile.ZIP_DEFLATED) as z:
        for diretorio, _, arquivos in os.walk(pasta):
            for arquivo in sorted(arquivos):
                caminho = os.path.join(diretorio, arquivo)
                rel = os.path.relpath(caminho, os.path.dirname(pasta))
                z.write(caminho, rel.replace(os.sep, "/"))
    print(f"Gerado: {saida}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
