import 'package:bmi_calculator/components/icon_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/icon_content.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import '../constants.dart';
import 'package:bmi_calculator/screens/results_page.dart';
import '../components/bottom_button.dart';
import '../components/round_icon_button.dart';
import 'package:bmi_calculator/calculator_brain.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  //selectedGender, pega as caracteristicas de Gender
  Gender selectedGender;
  int height = 180;//Altura Inicial
  int weight = 60;//Peso Inicial
  int age = 19;//Idade Inicial

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      //Cria a coluna
      body: Column(
        //Deixa a Coluna do meio totalmente espandida
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          //TODO: COLUNA INICIAL
          //Espande o row para colocar um do lado do outro
          Expanded(child: Row(
            children: <Widget>[
              //TODO: MALE
              Expanded(
                child: ReusableCard(
                  onPress: (){
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                  // ? = if
                  // : = else
                  colour: selectedGender == Gender.male
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.mars,
                    label: 'MALE',
                  ),
                ),
              ),

              //TODO: FEMALE
              Expanded(
                child: ReusableCard(
                  onPress: (){
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                  // ? = if
                  // : = else
                  colour: selectedGender == Gender.female
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.venus,
                    label: 'FEMALE',
                  ),
                )
              ),
            ],
          )),
          /**FIM DA COLUNA INICIAL**/

          //TODO: COLUNA DO MEIO
          Expanded(child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    //Deixa tudo centralizado
                    mainAxisAlignment: MainAxisAlignment.center,
                    //Deixa apenas a parte do valor na linha de base nesse caso o 'cm'
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    //Tem que especifar que é alfabetico
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: kNumberTextStyle
                      ),
                      Text(
                        'cm',
                        style: kLabelTextStyle,
                      )
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      //Cor da linha que não esta preencida
                      inactiveTrackColor: Color(0xFF8D8E98),
                      thumbColor: Color(0xFFEB1555),
                      //Almenta o tamanho do botao
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                      //Almenta o tamanho da tranparencia em volta do botão
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 30)
                    ),
                    child: Slider(
                      value: height.toDouble(),//Converte para double
                      min: 120.0,//Altura minima
                      max: 220.0,//Altura maxima
                      activeColor: Color(0xFFEB1555),//Cor do botão e da linha preenchida
                      onChanged: (double newValue){//Opção para arasta o botão
                        setState(() {
                          //O valor do botão muda conforme você meche na linha
                          height = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ),
          /**FIM DA COLUNA DO MEIO**/

          //TODO: COLUNA FINAL
          //Espande o row para colocar um do lado do outro
          Expanded(
            child: Row(
              children: <Widget>[
                //TODO: WEIGHT
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,//Cor do botão selecionado
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,// Estilo da letra dentro do quadro
                        ),
                        Text(
                          weight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          //Centraliza os dois botoes
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              //Botão menos
                              icon: FontAwesomeIcons.minus,
                              onPressed: (){
                                setState(() {
                                  weight--;
                                });
                              },
                            ),

                            SizedBox(
                              //Espaçamento entre os botões
                              width: 15,
                            ),

                            RoundIconButton(
                              //Botão mais
                              icon: FontAwesomeIcons.plus,
                              onPressed: (){
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ),

              //TODO: AGE
              Expanded(
                  child: ReusableCard(
                  colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: (){
                                setState(() {
                                  age--;
                                });
                              },
                            ),

                            SizedBox(
                              width: 15,
                            ),

                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: (){
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                )
              ),
            ],
          )),

          //TODO: CONTAINER DO FIM
          BottomButton(
            buttonTitle: 'CALCULATE',
              onTap: () {
                CalculatorBrain calc = CalculatorBrain(height: height, weight: weight,);

                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => ResultsPage(
                        bmiResults: calc.calculateBMI(),
                        resultText: calc.getResults(),
                        interpretation: calc.getInterpretation(),
                      )
                  )
              );
            },
          )
        ],
      )
    );
  }
}


