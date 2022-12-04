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

            "rgb(54, 162, 235)",
            "rgb(12, 3, 86)",

            "rgb(58, 81, 82)",
            "rgb(12, 3, 86)",
            "rgb(53, 1, 1)",
            "rgb(41, 42, 43)",
            "rgb(54, 33, 44)",
            "rgb(11, 22, 86)",
            "rgb(33, 99, 132)",
            "rgb(32, 123, 235)",
            "rgb(123, 205, 86)",
            "rgb(32, 99, 132)",
            "rgb(51, 162, 235)",
            "rgb(4, 205, 86)",
            "rgb(34, 99, 132)",
            "rgb(32, 162, 235)",
            "rgb(12, 205, 86)",
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