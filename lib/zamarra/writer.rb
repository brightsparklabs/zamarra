##
 # The Zamarra module contains a set of utlities for working with Zthes XML
 # documents
 # _____________________________________________________________________________
 #
 # Created by brightSPARK Labs
 # www.brightsparklabs.com
 ##

include Zamarra

module Zamarra

    ##
     # Writes out Zthes models
     ##
    class Writer

        ##
         # Writes the preferred terms hierarcy out to stdout
         #
         # @param document [ZthesDocument]
         #          document to write
         ##
        def self.write_preferred_terms(document)
            top_level_terms = document.top_level_terms
            top_level_terms.each { |term_id, term| print_name term }

        end

        private
            ##
             # Prints the name of the supplied term and all its children out to
             # stdout
             #
             # @param term [Term]
             #          term to write
             #
             # @param indent [Fixnum]
             #          number of spaces to prepend to name
             ##
            def self.print_name(term, indent=0)
                indentation = "".ljust(indent, " ")
                output = "#{indentation}- #{term.name}"
                output += " (#{term.synonyms.sort.join ', '})" unless term.synonyms.empty?
                puts output
                term.children.each { |child| child.nil? ? "== ERROR: UNKNOWN CHILD ==" : print_name(child, indent + 2) }
            end
    end
end
