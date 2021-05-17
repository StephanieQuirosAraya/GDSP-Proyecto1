package com.example.prueba

import android.os.Bundle
import android.os.StrictMode
import android.os.StrictMode.ThreadPolicy
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.textfield.TextInputEditText
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import okhttp3.*
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.RequestBody.Companion.toRequestBody
import java.io.IOException


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        /*val policy = ThreadPolicy.Builder().permitAll().build()
        StrictMode.setThreadPolicy(policy)*/

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)


        GlobalScope.async { prueba() }
        //prueba()

    }



    public fun buscarTipoRestaurante(view:View) {
        val textInputResType = findViewById<TextInputEditText>(R.id.textInputResType)
        val type = textInputResType.text
        val restTypeResult = findViewById<TextView>(R.id.restTypeResult)
        //val result = restTypeResult.setText("entre jeje")
        val url = "http://localhost:8080/api/v1/commerceOfMenus/" + type
        println(url)
        val request = Request.Builder().url(url).build()
        val client = OkHttpClient()
        client.newCall(request).enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {
                println("Failed to execute request")
            }

            override fun onResponse(call: Call, response: Response) {
                val body = response?.body?.string()
                println(body)
                val result = restTypeResult.setText(body)
            }
        })
        }
        public fun prueba() {
            val textInputResType = findViewById<TextInputEditText>(R.id.textInputResType)
            val type = textInputResType.text
            println(type)
            val restTypeResult = findViewById<TextView>(R.id.restTypeResult)
            //val result = restTypeResult.setText("entre jeje")
            val url = "https://192.168.100.5:8080/api/v1/commerceOfMenus/Americana"
            val client = OkHttpClient()
            println(url)
            val request = Request.Builder().url(url).get().build()
            println("Llegue a 67")
            val response = client.newCall(request).execute()
            println("Llegue a 69")
            val body = response.body!!.string()
            println("Llegue a 71")
            println("Resultado:" + body)
            val result = restTypeResult.setText(body)
            println("Llegue a 74")
        }

        /*val json = "application/json; charset=utf-8".toMediaType()

        val restTypeResult = findViewById<TextView>(R.id.restTypeResult)
        restTypeResult.text =*/
    }

    /*public fun rellenarResultados(lista: Array<String>){
        /*val arrayAdapter:ArrayAdapter<*>
        val restaurantes = mutableListOf(lista)
        val listVRestaurants = findViewById<ListView>(R.id.listVRestaurants)
        arrayAdapter = ArrayAdapter(applicationContext,android.R.layout.simple_list_item_1, listVRestaurants)
        */
        val listVRestaurants = findViewById<ListView>(R.id.listVRestaurants)
        var i = 0
        while(lista.size>i){

            i++
        }
    }*/
