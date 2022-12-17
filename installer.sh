#!/bin/bash
cd
# Clone the repository
git clone https://github.com/2128746/SplashScreen

# Ask the user if they want an analog or digital clock
echo "Do you want an analog or digital clock? (a/d)"
read clock_type

# Set the clock type in script.bash
if [ "$clock_type" = "a" ]; then
  sed -i '6s/.*/isDigital=false/' ./SplashScreen/script.bash
else
  sed -i '6s/.*/isDigital=true/' ./SplashScreen/script.bash
fi

# Ask the user if they want to use their IP or a specific city for the weather
echo "Do you want to use your IP or a specific city for the weather? (ip/city)"
read weather_type

# Set the weather type in script.bash
if [ "$weather_type" = "ip" ]; then
  sed -i '7s/.*/location=/' ./SplashScreen/script.bash
else
  echo "Enter the city you want to use for the weather: "
  read city
  sed -i "7s/.*/location='$city'/" ./SplashScreen/script.bash
fi
# Add a reference to script.bash in the bashrc file
echo "bash ~/splashscreen/script.bash" >> ~/.bashrc
