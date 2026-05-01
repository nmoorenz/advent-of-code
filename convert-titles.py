"""
Convert titles from 
Advent of Code 2025 Day 1
into 
2025 Day 1

So that we can see titles better on the AOC site
"""

from pathlib import Path
import re

directory = Path('.')
pattern='*.qmd'

for file_path in directory.rglob(pattern):
    filename = file_path.stem  # "2024-05" without .qmd
    
    # Match pattern: YYYY-DD
    match = re.match(r'(\d{4})-(\d{2})', filename)
    
    if not match:
        print(f"Filename doesn't match pattern YYYY-DD: {file_path.name}")
        continue
    
    year = match.group(1)
    day = match.group(2).lstrip('0')  # "05" -> "5"
    
    # Read the file
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Replace the title line
    new_content = re.sub(
        r'title:\s*["\'].*?["\']',
        f'title: "{year} Day {day}"',
        content
    )
 
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
