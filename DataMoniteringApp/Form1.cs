using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using ScottPlot;

namespace DataMoniteringApp
{
    public partial class Form1 : Form
    {
        List<SensorData> sensorDataList = new List<SensorData>();
        int activeSensor = 0;
        string connectionString = "Data Source=HovedPc\\SQLEXPRESS;Initial Catalog=TemperatureDatabase;Integrated Security=sspi;TrustServerCertificate=True";

        public List<SensorData> GetSensorInfo(string sqlConnectionString)
        {
            string sqlCommandString = "select * from GetSensorInfo";

            SqlConnection con = new SqlConnection(sqlConnectionString); ;
            con.Open();
            SqlCommand cmd = new SqlCommand(sqlCommandString, con);
            SqlDataReader reader = cmd.ExecuteReader();

            List<SensorData> sensorDatas = new List<SensorData>();

            if (reader != null)
            {
                while (reader.Read())
                {
                    SensorData sensorData = new SensorData();

                    sensorData.sensorDataId = Convert.ToInt32(reader["SensorId"]);
                    sensorData.sensorLocation = Convert.ToString(reader["RoomNumber"]);
                    sensorData.sensorType = Convert.ToString(reader["Type"]);
                    sensorData.sqlConnectionString = sqlConnectionString;

                    sensorDatas.Add(sensorData);
                }
            }
            con.Close();


            return sensorDatas;
        }

        public void plotData(SensorData sensorData)
        {
            int samplePoints = 20;
            List<Double> data = sensorData.collectNewestSensorData("CelsiusValue", samplePoints);
            double[] dataX = new double[data.Count()];
            double[] dataY = new double[data.Count()];

            int i = 0;
            foreach (var item in data)
            {
                dataY[i] = Convert.ToDouble(item);
                dataX[i] = Convert.ToDouble(i);
                i++;
            }


            formsPlot1.Plot.Add.Scatter(dataX, dataY);

            formsPlot1.Plot.Axes.AutoScale();
            formsPlot1.Refresh();

        }

        public void Program()
        {

            timer1.Interval = 1000;
            timer1.Start();


            sensorDataList = GetSensorInfo(connectionString);

            foreach (var sensor in sensorDataList)
            {
                var name = sensor.sensorLocation.ToString() + "." + sensor.sensorDataId;
                comboBox1.Items.Add(name);
            }

        }


        public Form1()
        {
            InitializeComponent();
            Program();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            plotData(sensorDataList[activeSensor]);
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            activeSensor = comboBox1.SelectedIndex;
            formsPlot1.Plot.Clear();
        }

        private void formsPlot1_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
    }



    public class SensorData
    {
        public int sensorDataId;
        public string sensorLocation;
        public string sensorType;

        public string sqlConnectionString;

        public List<Double> collectNewestSensorData(string temperatureScale, int numSamples)
        {
            string sqlCommandString = "select top " + 
                                    numSamples.ToString() + 
                                    " " +
                                    temperatureScale.ToString() +
                                    " from LOG where SensorId = " + 
                                    sensorDataId.ToString();

            SqlConnection con = new SqlConnection(sqlConnectionString);

            con.Open();
            SqlCommand cmd = new SqlCommand(sqlCommandString, con);
            SqlDataReader reader = cmd.ExecuteReader();

            List<Double> sensorData = new List<Double>();
            while (reader.Read())
            {
                sensorData.Add(Convert.ToDouble(reader[0]));
            }
            return sensorData;
        }
    }
}
