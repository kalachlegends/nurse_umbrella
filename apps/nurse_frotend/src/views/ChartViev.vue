<template>
  <h1>Популярные теги</h1>
  <canvas id="myChart"></canvas>
</template>
  
  <script>
import axios from "@/axios";
export default {
  async mounted() {
    const response = await axios.get("/content/popular_tabs");
    console.log(response);

    const ctx = document.getElementById("myChart");
    const data = {
      labels: response.data.data.map((el) => el.name),
      datasets: [
        {
          label: "Ваши популярные слова",
          data: response.data.data.map((el) => el.count),
          backgroundColor: [
            "rgb(255, 99, 132)",
            "rgb(54, 162, 235)",
            "rgb(255, 205, 86)",
          ],
          hoverOffset: 4,
        },
      ],
    };
    const config = {
      type: "pie",
      data: data,
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: "top",
          },
          title: {
            display: true,
            text: "Chart.js Pie Chart",
          },
        },
      },
    };
    new Chart(ctx, config, data);
  },
};
</script>