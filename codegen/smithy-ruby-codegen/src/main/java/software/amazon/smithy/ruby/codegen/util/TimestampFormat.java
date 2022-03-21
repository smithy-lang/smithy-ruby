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

package software.amazon.smithy.ruby.codegen.util;

import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.traits.TimestampFormatTrait;
import software.amazon.smithy.utils.SmithyUnstableApi;

@SmithyUnstableApi
public final class TimestampFormat {

    private TimestampFormat() {
    }

    public static String serializeTimestamp(TimestampShape shape, MemberShape memberShape, String input,
                                            TimestampFormatTrait.Format defaultFormat) {
        TimestampFormatTrait.Format format = memberShape
                .getTrait(TimestampFormatTrait.class)
                .map((t) -> t.getFormat())
                .orElseGet(() ->
                        shape.getTrait(TimestampFormatTrait.class)
                                .map((t) -> t.getFormat())
                                .orElse(defaultFormat));

        switch (format) {
            case EPOCH_SECONDS:
                return String.format("Hearth::TimeHelper.to_epoch_seconds(%s)", input);
            case HTTP_DATE:
                return String.format("Hearth::TimeHelper.to_http_date(%s)", input);
            case DATE_TIME:
            default:
                return String.format("Hearth::TimeHelper.to_date_time(%s)", input);
        }
    }
}
