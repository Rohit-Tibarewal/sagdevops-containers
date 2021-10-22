ARG PRODUCT_IMAGE

FROM $PRODUCT_IMAGE as default
COPY --chown=sagadmin assets/Packages /opt/softwareag/IntegrationServer/packages/
RUN ls -la /opt/softwareag/IntegrationServer/packages/
RUN mkdir -p /tmp/isccr

COPY isccr/GCS_IS_ContinuousCodeReview_v8.1.0.zip /tmp/isccr/

RUN cd /tmp/isccr && unzip GCS_IS_ContinuousCodeReview_v8.1.0.zip && rm GCS_IS_ContinuousCodeReview_v8.1.0.zip

RUN CodeReview.sh -Dcode.review.directory=/opt/softwareag/IntegrationServer/packages/ -Dcode.review.runmode=MULTI -Dcode.review.pkgprefix=MediaApp,Fibo,Dev -Dcode.review.folder-prefix=MediaApp,Fibo,Dev
#EXPOSE 5555

#COPY --chown=sagadmin ./scripts /src/scripts
#RUN chmod +x /src/scripts/*.sh

#ENV JAVA_HOME=/opt/softwareag/jvm/jvm
#ENV PATH=$JAVA_HOME/bin:$PATH

#ENTRYPOINT /src/scripts/Entrypoint.sh
