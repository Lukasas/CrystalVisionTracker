import requests
from bs4 import BeautifulSoup
import re

def get_heading_from_url(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ' +
                      '(KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36'
    }
    response = requests.get(url, headers=headers)
    response.raise_for_status()

    soup = BeautifulSoup(response.text, 'html.parser')
    heading = soup.find(class_='heading-size-1')
    
    if heading:
        return heading.text.strip()
    else:
        return None

def get_names_for_all_languages_from_url(url):
    languages = ["fr", "de", "es", "mx", "it", "pt", "ru", "cn", "tw", "ko"]
    lang_res_keys = {"fr": "frFR", "de": "deDE", "es": "esES", "mx": "esMX",
                     "it": "itIT", "pt": "ptBR", "ru": "ruRU", "cn": "zhCN",
                     "tw": "zhTW", "ko": "koKR"}
    results = {}

    # Extract the last part after the base URL "https://www.wowhead.com/"
    base_url = "https://www.wowhead.com/"
    query_object = url.split(base_url)[-1]

    print(f"Processing URL: {url}")
    results['enUS'] = get_heading_from_url(url)

    # Other languages
    for lang in languages:
        lang_url = f"{base_url}{lang}/{query_object}"
        print(f"Processing language {lang.upper()} URL: {lang_url}")
        results[lang_res_keys[lang]] = get_heading_from_url(lang_url)

    return results

def to_lua_table(name, lines):
    lua_lines = ["{"]
    for k, v in lines.items():
        v_escaped = (v or "").replace('"', '\\"')
        lua_lines.append(f'    {k} = "{v_escaped}",')
    lua_lines.append("}")
    return "\n".join(lua_lines)

if __name__ == "__main__":
    lua_table = {}
    for name, url in {
        "Odd Crystal": "https://www.wowhead.com/object=341369", # /odd-crystal
        "Black Empire Cache": "https://www.wowhead.com/object=500108", # /black-empire-cache
        "Vision of Orgrimmar": "https://www.wowhead.com/zone=15946", # /vision-of-orgrimmar
        "Visionof Stormwind": "https://www.wowhead.com/zone=15942", # /vision-of-stormwind
        "Chamber of Heart": "https://www.wowhead.com/zone=9667", # /chamber-of-heart
        "Morgan Pestle": "https://www.wowhead.com/npc=162231", # /morgan-pestle
        "Voidbound Ravager": "https://www.wowhead.com/npc=162629", # /voidbound-ravager
        "Vial of Mysterious Black Liquid": "https://www.wowhead.com/object=341337", # /vial-of-mysterious-black-liquid
        "Vial of Mysterious Green Liquid": "https://www.wowhead.com/object=341339", # /vial-of-mysterious-green-liquid
        "Vial of Mysterious Red Liquid": "https://www.wowhead.com/object=341341", # /vial-of-mysterious-red-liquid
        "Vial of Mysterious Blue Liquid": "https://www.wowhead.com/object=341338", # /vial-of-mysterious-blue-liquid
        "Vial of Mysterious Purple Liquid": "https://www.wowhead.com/object=341340", # /vial-of-mysterious-purple-liquid
    }.items():
        try:
            names = get_names_for_all_languages_from_url(url)
            lua_table[name] = to_lua_table(name, names)
        except Exception as e:
            print(f"Error: {e}")
    for k,v in lua_table.items():
        print(f"[\"{k}\"] = {v},")