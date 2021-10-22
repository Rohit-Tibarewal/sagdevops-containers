#!/bin/sh
# webMethods Integration Server Continuous Code Review (ISCCR)
# Software AG Global Consulting Services
# Authors: Dave.Pemberton@softwareAG.com
#          Stuart.Fyffe-Collins@softwareAG.com
# --------------------------------------------

# Set the code review home directory
# for where to find the files

# If using Jenkins, this will need changing
# to the fully qualified path name

export CODEREVIEW_HOME=.

#
# Adapt to alternative JRE (1.8) if necessary
# export JAVA_HOME=/opt/softwareag/jvm/jvm

if [ "$1" = "-?" ] || [ "$1" = "-help" ] || [ "$1" = "-h" ]
then
echo Starting Continuous Code Review 

echo Parameter not supplied
echo Usage
echo ---------------------
echo CodeReview [Parameters] 
echo 
echo Where Parameters can be any java system property, e.g.
echo  CodeReview 
echo
echo      -Dcode.review.directory=c:\Jenkins\jobs\IotDemo\workspace [CODE LOCATION       ]
echo      -Dcode.review.pkgname=IotDemo                             [PACKAGE NAME        ]
echo      -Dcode.review.pkgprefix=Iot                               [PACKAGE PREFIX      ]
echo      -Dcode.review.options=customOptions.xml                   [OVERRIDE CONFIG FILE]
echo ---------------------
exit 0
fi

#
# Execute
#
CLASSPATH=$CODEREVIEW_HOME/lib/GCS_ContinuousCodeReview-Common.jar
CLASSPATH=$CLASSPATH:$CODEREVIEW_HOME/lib/GCS_ContinuousCodeReview-Pub.jar
CLASSPATH=$CLASSPATH:$CODEREVIEW_HOME/lib/GCS_ContinuousCodeReview-impl.jar
CLASSPATH=$CLASSPATH:$CODEREVIEW_HOME/lib/lm.jar
CLASSPATH=$CLASSPATH:$CODEREVIEW_HOME/lib/xom-1.2.10.jar
CLASSPATH=$CLASSPATH:$CODEREVIEW_HOME/classes

$JAVA_HOME/bin/java $* -classpath $CLASSPATH com.softwareag.gcs.wm.codereview.CodeReview
