/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */
package software.amazon.smithy.ruby.codegen;

import java.util.Objects;
import software.amazon.smithy.codegen.core.Symbol;


/**
 * Represents the resolves {@link Symbol}s and references for an
 * application Transport (aka Application Protocol) (e.g., "http", "mqtt", etc).
 */
public final class ApplicationTransport {

    private final String name;
    private final Symbol requestType;
    private final Symbol responseType;

    /**
     * Creates a resolved application transport.
     *
     * @param name         The transport name (e.g., http, mqtt, etc).
     * @param requestType  The type used to represent request messages for the transport.
     * @param responseType The type used to represent response messages for the transport.
     */
    public ApplicationTransport(
            String name,
            Symbol requestType,
            Symbol responseType
    ) {
        this.name = name;
        this.requestType = requestType;
        this.responseType = responseType;
    }

    /**
     * Creates a default HTTP application transport.
     *
     * @return Returns the created application Transport.
     */
    public static ApplicationTransport createDefaultHttpApplicationTransport() {
        return new ApplicationTransport(
                "http",
                createHttpSymbol("Request"),
                createHttpSymbol("Response")
        );
    }

    private static Symbol createHttpSymbol(String symbolName) {
        return Symbol.builder()
                .namespace("Seahorse::HTTP", "::")
                .name(symbolName).build();
    }

    /**
     * Gets the Transport name.
     *
     * <p>All HTTP Transports should start with "http".
     * All MQTT Transports should start with "mqtt".
     *
     * @return Returns the Transport name.
     */
    public String getName() {
        return name;
    }

    /**
     * Checks if the Transport is an HTTP based Transport.
     *
     * @return Returns true if it is HTTP based.
     */
    public boolean isHttpTransport() {
        return getName().startsWith("http");
    }

    /**
     * Gets the symbol used to refer to the request type for this Transport.
     *
     * @return Returns the Transport request type.
     */
    public Symbol getRequestType() {
        return requestType;
    }

    /**
     * Gets the symbol used to refer to the response type for this Transport.
     *
     * @return Returns the Transport response type.
     */
    public Symbol getResponseType() {
        return responseType;
    }

    @Override
    public String toString() {
        return "ApplicationTransport<" +
                getName() + ", request: " +
                getRequestType() + ", response: " + getRequestType() + ">";
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (!(o instanceof ApplicationTransport)) {
            return false;
        }

        ApplicationTransport that = (ApplicationTransport) o;
        return requestType.equals(that.requestType)
                && responseType.equals(that.responseType);
    }

    @Override
    public int hashCode() {
        return Objects.hash(requestType, responseType);
    }
}