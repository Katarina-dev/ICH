import plotly.express as px
import polars as pl
import numpy as np


#####
# Загружаем данные
df = px.data.carshare()

# функция для классификации доступности автомобилей
def classify_availability(hours):
    if hours < 500:
        return "Низкая (<500)"
    elif 500 <= hours <= 2000:
        return "Средняя (500-2000)"
    else:
        return "Высокая (>2000)"

# создание нового столбца с категориями доступности
df['Доступность'] = df['car_hours'].apply(classify_availability)

# группировка по категориям доступности
availability_counts = df.groupby('Доступность')['car_hours'].count().reset_index()
availability_counts.rename(columns={'car_hours': 'Количество автомобилей'}, inplace=True)


from dash import Dash, html, dcc, callback, Output, Input
import plotly.express as px
from plotly.subplots import make_subplots
import plotly.graph_objects as go


# Определяем гистограмму времени доступности автомобилей
fig1 = px.histogram(
    df,
    x='car_hours',
    nbins=42,
    title="Распределение времени доступности автомобилей",
    labels={'car_hours': 'Временя доступности'}
)



####################
# Определяем пирог
fig2 = px.pie(
    availability_counts,
    values='Количество автомобилей',
    names='Доступность',
    color_discrete_map={
        "Низкая": "lightred",
        "Средняя": "lightblue",
        "Высокая": "lightgreen"
    }
)

fig2.update_layout(
    legend_title="Категория доступности"
)

######################
# Создаем общую картинку
fig = make_subplots(rows=1, cols=2, specs=[[{'type':'xy'}, {'type':'domain'}]], subplot_titles = ("Количество автомобилей","Процент автомобилей по категории доступности"))

#########
# Добавлем два гарфика
fig.add_trace(fig1.data[0], row=1, col=1)
fig.add_trace(fig2.data[0], row=1, col=2)

# Оформляем
fig.update_xaxes(title_text="Время доступности (мин)", row=1, col=1)
fig.update_yaxes(title_text="Количество автомобилей", row=1, col=1)
fig.update_layout(
    title="Два графика по каршерингу",
    legend_title_text="Категория доступности"
)

##############
# Создаем и запускаем приложение на порту 8051
app = Dash()

app.layout = html.Div([
    html.H1('Our main dashboard'),
    dcc.Graph(figure=fig),
])
   

if __name__ == '__main__':
    app.run()