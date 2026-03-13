package com.equitybankgroup.vas.hostemulator.emulator.util;

import com.google.common.base.Strings;
import com.google.common.collect.Sets;
import org.hibernate.validator.constraints.NotBlank;

import javax.ejb.ApplicationException;
import javax.validation.constraints.NotNull;
import java.util.Collection;
import java.util.Collections;
import java.util.Set;

/**
 * @author pg
 */
@ApplicationException(rollback = true)
public class RollBackCheckedException extends Exception {

    private Set<String> messages = Sets.newLinkedHashSet();

    public RollBackCheckedException() {
        super();
    }

    public RollBackCheckedException(@NotBlank final String message) {
        super(message);
        messages.add(message);
    }

    public RollBackCheckedException(@NotBlank final String message, @NotNull final Throwable cause) {
        super(message, cause);
        messages.add(message);
    }

    public RollBackCheckedException(@NotNull final Throwable cause) {
        super(cause);
        if (Strings.isNullOrEmpty(cause.getMessage())) {
            return;
        }
        messages.add(cause.getMessage());
    }

    public RollBackCheckedException addMessage(@NotBlank final String message) {
        messages.add(message);
        return this;
    }

    public RollBackCheckedException addMessages(@NotBlank final Collection<String> allMessages) {
        messages.addAll(allMessages);
        return this;
    }

    public boolean hasMessages() {
        return !messages.isEmpty();
    }

    public Set<String> getMessages() {
        return Collections.unmodifiableSet(messages);
    }
}
