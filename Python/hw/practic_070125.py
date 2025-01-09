#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import os
import requests
from bs4 import BeautifulSoup

# Функция для получения URL-ов картинок с атрибутом loading="lazy"
def get_image_urls(url, max_images=30):
    response = requests.get(url)
    if response.status_code != 200:
        raise Exception(f"Не удалось загрузить страницу: {response.status_code}")

    soup = BeautifulSoup(response.text, 'html.parser')
    # Находим все теги <img> с атрибутом loading="lazy"
    img_tags = soup.find_all('img', attrs={'loading': 'lazy'})
    # Получаем URL-ы картинок
    img_urls = [img['src'] for img in img_tags if 'src' in img.attrs]
    return img_urls[:max_images]  # Возвращаем только нужное количество

# Функция для скачивания картинок
def download_images(image_urls, save_dir='flickr_images'):
    # Создаем директорию, если она не существует
    os.makedirs(save_dir, exist_ok=True)

    for idx, img_url in enumerate(image_urls):
        try:
            response = requests.get(img_url, stream=True)
            if response.status_code == 200:
                # Сохраняем картинку в файл
                filename = os.path.join(save_dir, f'image_{idx + 1}.jpg')
                with open(filename, 'wb') as file:
                    for chunk in response.iter_content(1024):
                        file.write(chunk)
                print(f"Скачано: {filename}")
            else:
                print(f"Ошибка скачивания: {img_url}")
        except Exception as e:
            print(f"Ошибка: {e} при скачивании {img_url}")

# Основной блок
if __name__ == "__main__":
    # URL страницы Explore | Flickr
    flickr_url = "https://www.flickr.com/explore"
    try:
        # Получаем URL картинок
        urls = get_image_urls(flickr_url)
        print(f"Найдено {len(urls)} картинок.")
        print("URL картинок:")
        print("\n".join(urls))

        # Скачиваем картинки (опционально)
        download_images(urls)
    except Exception as e:
        print(f"Ошибка выполнения: {e}")


# In[ ]:




