<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <!-- RJP:2017-10-08: Rules regarding person and place referencing. -->
    <pattern>
        <rule context="tei:body//tei:persName">
            <report test="not(@ref)"> The persName element must have an @ref. </report>
        </rule>
    </pattern>
    <let name="persList" value="//tei:back//tei:listPerson/tei:person/@xml:id"/>
    <pattern>
        <rule context="tei:body//tei:persName/@ref">
            <let name="tokens"
                value="
                    for $i in tokenize(., '\s+')
                    return
                        substring-after($i, '#')"/>
            <assert
                test="
                    every $token in $tokens
                        satisfies $token = $persList"
                > The attribute, after the hashtag (#), must match a defined @xml:id in the
                listPerson in the back of the master XML file. </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:placeName">
            <report test="not(@ref)"> The placeName element must have an @ref. </report>
        </rule>
    </pattern>
    <let name="placeList" value="//tei:back//tei:listPlace/tei:place/@xml:id"/>
    <pattern>
        <rule context="tei:body//tei:placeName/@ref">
            <let name="tokens"
                value="
                    for $i in tokenize(., '\s+')
                    return
                        substring-after($i, '#')"/>
            <assert
                test="
                    every $token in $tokens
                        satisfies $token = $placeList"
                > The attribute, after the hashtag (#), must match a defined @xml:id in the
                listPlace in the back of the master XML file. </assert>
        </rule>
    </pattern>
    <!-- RJP:2017-10-08: Rules regarding currency and commodity values. -->
    <pattern>
        <rule context="tei:body//tei:measure[@type = 'currency']">
            <report test="not(@ana)"> Whenever there is currency mentioned you need to indicate the
                value in an @ana attribute. </report>
            <report test="not(@unit)"> Whenever there is currency mentioned you need to indicate the
                value's unit (dollars or £sd) in an @unit attribute. </report>
            <assert test="@unit = '£sd' or @unit = 'dollars'">The currency unit can only be £sd
                (pound, shillings, pence) or dollars.</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:measure[@type = 'currency'][@unit = '£sd']/@ana">
            <assert test="matches(., '\d\d_\d\d_\d\d')"> This @ana attribute (because the @unit is
                £sd) must match the following format: ##_##_## </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:measure[@type = 'currency'][@unit = 'dollars']/@ana">
            <assert test="matches(., '\d{1,}\.\d\d')"> This @ana attribute (because the @unit is
                dollars) must match the following format: #.## </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:measure[@commodity]">
            <report test="not(@commodity) or not(@quantity) or not(@unit)">The commodity measurement
                must only have attributes commodity, quantity, and unit.</report>
            <assert
                test="@unit = 'whole' or @unit = 'lb' or @unit = 'ft' or @unit = 'bought' or @unit = 'bushels' or @unit = 'barrel' or @unit = 'qt' or @unit = 'load' or @unit = 'gallon' or @unit = 'bundles' or @unit = 'pair'"
                >The @unit can only be equal to: whole, lb, ft, bought, bushels, barrel, qt, load,
                gallon, bundles, or pair.</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:measure">
            <assert test="@type = 'currency' or @commodity"> The measure element can only represent
                either a measurement of currency or a measurement of a commodity. Therefore, you
                must have @type="currency" or @commodity but NOT BOTH! </assert>
        </rule>
    </pattern>
    <!-- RJP:2017-10-08 Rules regarding basic XML structure -->
    <pattern>
        <rule context="tei:div">
            <assert test="@type = 'page' or @type = 'group'"> The div element can only have the
                @type equal to page or group. </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:div[@type = 'page']">
            <report test="not(@facs)"> The div element indicating a transcribed/encoded page must
                have a facs attribute pointing to the manuscript image.</report>
            <assert test="count(child::tei:div[@type = 'group']) ge 1"> The div element indicating a
                transcribed/encoded page must have at least one child div @type="group", which
                contains the group of entries for any single account.</assert>
            <assert test="count(child::tei:head) eq 0"> The div @type="page" does not have a head
                element. Be sure you did not intend to put this head element inside of a div
                @type="group".</assert>
            <!--<report test="not(@subtype='credit') or not(@subtype='debt')">Every page element should have a subtype equal to credit or debt. </report>-->
            <!-- RJP:2017-10-28: We have been able to determine credit vs debt via the page number (even or odd, left or right) so this rule is not necessary. -->
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:div[@type = 'group']">
            <report test="not(parent::tei:div[@type = 'page'])">The group div should always appear
                as a child of a page div.</report>
            <assert test="count(child::tei:head) eq 1"> Every div @type="group" must have a child
                head element. Even if there is not text that would belong in the head element still
                include it (just leave it empty).</assert>
            <assert test="count(child::tei:list[@type = 'entry']) ge 1"> Every div @type="group"
                must have at least one child list @type="entry".</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:list">
            <assert test="@type = 'entry'"> All list elements must have an @type="list". </assert>
            <report test=".[@subtype]/not(@subtype = 'total')"> This attribute on the list element
                is not allowed. List can only have @subtype="total". </report>
            <assert test="child::tei:item">Every list should have at least one line item.</assert>
        </rule>
    </pattern>
    <!-- RJP:2017-10-18 Rules regarding the date element. -->
    <pattern>
        <rule context="tei:body//tei:date">
            <report test="not(@when)"> The date element must have an @when containing the ISO
                standard date. </report>
            <assert test="matches(@when, '\d\d\d\d-\d\d-\d\d') or matches(@when, '\d\d\d\d-\d\d')">
                The @when on the date element should be ISO standard, YYYY-MM-DD or
                YYYY-MM.</assert>
        </rule>
    </pattern>
    <!-- RJP:2017-10-08 Rules regarding idosyncratic spelling, Bartram's symbols, and unclear text. -->
    <pattern>
        <rule context="tei:body//tei:add">
            <report test="not(@resp)"> The add element must have an @resp indicating the editor
                responsible for this added information. </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:supplied">
            <report test="not(@resp)"> The add element must have an @resp indicating the editor
                responsible for this added information. </report>

        </rule>
    </pattern>
    <pattern>
        <rule context="tei:body//tei:reg">
            <report test="not(@resp)"> The add element must have an @resp indicating the editor
                responsible for this added information. </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:choice">
            <assert test="child::tei:sic and child::tei:reg">Choice must contain a sic element (for
                the idiosyncratic word) and reg element (for the regularized word).</assert>
        </rule>
    </pattern>
    <let name="respList" value="//tei:teiHeader//tei:respStmt/tei:persName/@xml:id"/>
    <pattern>
        <rule context="tei:*[@resp]">
            <let name="tokens"
                value="
                    for $i in tokenize(@resp, '\s+')
                    return
                        substring-after($i, '#')"/>
            <assert
                test="
                    every $token in $tokens
                        satisfies $token = $respList"
                >The attribute, after the hashtag (#), must match a defined @xml:id in a respStmt
                listed at the top of the file in the teiHeader. (BC = Bruce Clarke, DM = Don Marks,
                SG = Susan Graham, BN = Beth Northrop, RP = Rebecca Parker, and RF = Robert
                Foley)</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:unclear">
            <assert test="@reason and @unit and @quantity">The unclear element must have attributes
                reason, unit, and quantity.</assert>
            <assert test="@reason = 'strikethrough' or @reason = 'illegible'">The @reason must be
                equal to strikethrough or illegible.</assert>
            <assert test="@unit = 'chars' or @unit = 'words'">The @unit must be equal to chars (for
                characters) or words.</assert>
            <!--<assert test="@quantity='matches(.,\d{1,}'">The @quantity must be a whole number.</assert>-->
            <!-- RJP:2017-10-28: This is not working. -->
        </rule>
        <rule context="tei:unclear[count(tei:supplied) gt 1]/child::tei:supplied">
            <assert test="@n and @cert">When there are more than one guesses at the supplied text it
                is important to include the n atrribute indicating which guess was transcribed first
                and the cert attribute indicating the certainty of the guess in comparison to the
                other guesses.</assert>
            <assert test="@cert = 'low' or @cert = 'high' or @cert = 'medium'">The cert attribute
                can only be equal to low, medium, or high. High meaning most certain of the guesses
                supplied.</assert>
        </rule>
    </pattern>
    <let name="gList" value="//tei:teiHeader//tei:charDecl/tei:char/@xml:id"/>
    <pattern>
        <rule context="tei:g">
            <let name="tokens"
                value="
                    for $i in tokenize(@ref, '\s+')
                    return
                        substring-after($i, '#')"/>
            <assert
                test="
                    every $token in $tokens
                        satisfies $token = $gList"
                >The attribute, after the hashtag (#), must match a defined @xml:id of a char
                element listed at the top of the file in the charDecl of the teiHeader.
                (#longHyphen, #ditto, #afterName, #stItem, #currency)</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:g[@ref = '#ditto']">
            <assert test="following-sibling::tei:add">You must define what the ditto mark is
                representing by following this g element with an add element.</assert>
        </rule>
        <rule context="tei:g[@ref='#longHyphen']">
            <assert test="@n">Every hyphen reference must indicate the number of hyphens that appear in the manuscript in a @n attribute.</assert>
        </rule>
    </pattern>

</schema>
