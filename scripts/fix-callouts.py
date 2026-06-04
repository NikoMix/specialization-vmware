"""Fix download-callout JSX expressions where PowerShell heredoc ate backticks."""
import re
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent / 'src' / 'content' / 'docs'

# Replace bare ${import.meta.env.BASE_URL}path with backtick-wrapped form
pattern = re.compile(r'href=\{\$\{import\.meta\.env\.BASE_URL\}([^\}]+)\}')

def fix(p):
    txt = p.read_text(encoding='utf-8')
    new = pattern.sub(lambda m: f'href={{`${{import.meta.env.BASE_URL}}{m.group(1)}`}}', txt)
    if new != txt:
        p.write_text(new, encoding='utf-8')
        print(f'fixed: {p.relative_to(ROOT)}')

for p in ROOT.rglob('*.mdx'):
    fix(p)
